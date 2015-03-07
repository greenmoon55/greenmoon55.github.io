---
layout: post
title: OpenStack Horizon Filter 功能的实现
published: true
---


怕自己以后忘了，随手记一下。

下图是 admin dashboard 里的 filter，可根据 Project 和 Name 过滤 instance。

![](/images/horizon-filter-admin.png)

下图是 project dashboard 里的 filter，可以过滤表格里的任意一列

![](/images/horizon-filter-project.png)

代码以当前 stable/icehouse 分支为准

首先从后端看起，[horizon/tables/actions.py](https://github.com/openstack/horizon/blob/cfa611bedf14c9b1ef0b5689b6942aa6431e6313/horizon/tables/actions.py) 有 FilterAction class

```python
class FilterAction(BaseAction):
```


[openstack_dashboard/dashboards/project/instances/tables.py](https://github.com/openstack/horizon/blob/cfa611bedf14c9b1ef0b5689b6942aa6431e6313/openstack_dashboard/dashboards/project/instances/tables.py) 有

```python
class InstancesFilterAction(tables.FilterAction):

    def filter(self, table, instances, filter_string):
        """Naive case-insensitive search."""
        q = filter_string.lower()
        return [instance for instance in instances
                if q in instance.name.lower()]admin
```

[openstack_dashboard/dashboards/admin/instances/tables.py](https://github.com/openstack/horizon/blob/cfa611bedf14c9b1ef0b5689b6942aa6431e6313/openstack_dashboard/dashboards/admin/instances/tables.py)

```python
class AdminInstanceFilterAction(tables.FilterAction):
    filter_type = "server"
    filter_choices = (('project', _("Project")),
                      ('name', _("Name"))
                      )
    needs_preloading = True

    def filter(self, table, instances, filter_string):
        """Server side search.
        When filtering is supported in the api, then we will handle in view
        """
        filter_field = table.request.POST.get('instances__filter__q_field')
        self.filter_field = filter_field
        self.filter_string = filter_string
        if filter_field == 'project' and filter_string:
            return [inst for inst in instances
                    if inst.tenant_name == filter_string]
        if filter_field == 'name' and filter_string:
            q = filter_string.lower()
            return [instance for instance in instances
                    if q in instance.name.lower()]
        return instances
```

然后我们看下前端的实现，[horizon/templates/horizon/common/_data_table_table_actions.html](https://github.com/openstack/horizon/blob/cfa611bedf14c9b1ef0b5689b6942aa6431e6313/horizon/templates/horizon/common/_data_table_table_actions.html)

可以看到这里有三种 `filter_type`，InstancesFilterAction 默认是 query，AdminInstanceFilterAction 是 server。query 和 server 有什么不同呢？我们去看看 js。

```javascript
horizon.datatables.set_table_query_filter = function (parent) {
  $(parent).find('table').each(function (index, elm) {
    var input = $($(elm).find('div.table_search.client input')),
        table_selector;
    if (input.length > 0) {
      // Disable server-side searcing if we have client-side searching since
      // (for now) the client-side is actually superior. Server-side filtering
      // remains as a noscript fallback.
      // TODO(gabriel): figure out an overall strategy for making server-side
      // filtering the preferred functional method.
      input.on('keypress', function (evt) {
        if (evt.keyCode === 13) {
          return false;
        }
      });
      input.next('button.btn-search').on('click keypress', function (evt) {
        return false;
      });

      // Enable the client-side searching.
      table_selector = 'table#' + $(elm).attr('id');
      input.quicksearch(table_selector + ' tbody tr', {
        'delay': 300,
        'loader': 'span.loading',
        'bind': 'keyup click',
        'show': this.show,
        'hide': this.hide,
        onBefore: function () {
          var table = $(table_selector);
          horizon.datatables.remove_no_results_row(table);
        },
        onAfter: function () {
          var template, table, colspan, params;
          table = $(table_selector);
          horizon.datatables.update_footer_count(table);
          horizon.datatables.add_no_results_row(table);
          horizon.datatables.fix_row_striping(table);
        },
        prepareQuery: function (val) {
          return new RegExp(val, "i");
        },
        testQuery: function (query, txt, _row) {
          return query.test($(_row).find('td:not(.hidden):not(.actions_column)').text());
        }
      });
    }
  });
};
```

如果 filter_type 是 query，就直接调用 js 来 filter，用的是 [jQuery quicksearch](https://github.com/DeuxHuitHuit/quicksearch)。（Icehouse 好像用的不是这个版本）

那么服务端的 filter 是怎么实现的呢？

[horizon/tables/base.py](https://github.com/openstack/horizon/blob/cfa611bedf14c9b1ef0b5689b6942aa6431e6313/horizon/tables/base.py)

class DataTable 里的 filtered_data 会调用 action 的 filter 函数，而 get_rows 函数会从 filtered_data 里读数据。

```python
    @property
    def filtered_data(self):
        # This function should be using django.utils.functional.cached_property
        # decorator, but unfortunately due to bug in Django
        # https://code.djangoproject.com/ticket/19872 it would make it fail
        # when being mocked by mox in tests.
        if not hasattr(self, '_filtered_data'):
            self._filtered_data = self.data
            if self._meta.filter and self._meta._filter_action:
                action = self._meta._filter_action
                filter_string = self.get_filter_string()
                request_method = self.request.method
                needs_preloading = (not filter_string
                                    and request_method == 'GET'
                                    and action.needs_preloading)
                valid_method = (request_method == action.method)
                if valid_method or needs_preloading:
                    if self._meta.mixed_data_type:
                        self._filtered_data = action.data_type_filter(self,
                                                                self.data,
                                                                filter_string)
                    else:
                        self._filtered_data = action.filter(self,
                                                            self.data,
                                                            filter_string)
        return self._filtered_data

    def get_rows(self):
        """Return the row data for this table broken out by columns."""
        rows = []
        try:
            for datum in self.filtered_data:
                row = self._meta.row_class(self, datum)
                if self.get_object_id(datum) == self.current_item_id:
                    self.selected = True
                    row.classes.append('current_selected')
                rows.append(row)
        except Exception:
            # Exceptions can be swallowed at the template level here,
            # re-raising as a TemplateSyntaxError makes them visible.
            LOG.exception("Error while rendering table rows.")
            exc_info = sys.exc_info()
            raise template.TemplateSyntaxError, exc_info[1], exc_info[2]
        return rows
```

