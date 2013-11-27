---
layout: post
title: Horizon 中 Python 元编程的例子
---

Horizon 中创建虚拟机的 workflows 里面有这样一个类，用来选择虚拟机的一些信息，比如配置。[GitHub代码](https://github.com/openstack/horizon/blob/cde81c38027b17014abcd1449a263bdc411503cc/openstack_dashboard/dashboards/project/instances/workflows/create_instance.py#L170)

```python
class SetInstanceDetailsAction(workflows.Action):
```

里面有这几个方法

```python
def populate_image_id_choices(self, request, context):
    images = self._get_available_images(request, context)
    choices = [(image.id, image.name)
               for image in images
               if image.properties.get("image_type", '') != "snapshot"]
    if choices:
        choices.insert(0, ("", _("Select Image")))
    else:
        choices.insert(0, ("", _("No images available.")))
    return choices

def populate_instance_snapshot_id_choices(self, request, context):
    .
    .
    .

def populate_flavor_choices(self, request, context):
    .
    .
    .
```

这几个方法是用来填充一些页面上的选择框的，看来看去不知道是在哪里被调用的。

于是找父类 [workflows.Action](https://github.com/openstack/horizon/blob/cde81c38027b17014abcd1449a263bdc411503cc/horizon/workflows/base.py#L77)

```python
def _populate_choices(self, request, context):
    for field_name, bound_field in self.fields.items():
        meth = getattr(self, "populate_%s_choices" % field_name, None)
        if meth is not None and callable(meth):
            bound_field.choices = meth(request, context)
```
哈，原来在这里，看出来做什么了吧。太具体的我也还没研究= =


最后，在 `__init__` 中有一行。

```python
self._populate_choices(request, context)
```

看大牛写的高质量代码也有点意思，我想吐槽貌似 Django 的文档不够全面啊，至少跟 Rails 比。

