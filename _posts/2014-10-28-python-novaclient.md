---
layout: post
title: Novaclient 载入 extensions 的过程
published: true
---

`novaclient/v1_1/contrib`里可以加入新的指令，例如：
```python
@utils.arg('server',
        metavar='<server>',
        help=_('Name or UUID of the server to list actions for.'))
def do_instance_action_list(cs, args):
    """List actions on a server."""
    server = utils.find_resource(cs.servers, args.server)
    actions = cs.instance_action.list(server)
    utils.print_list(actions,
        ['Action', 'Request_ID', 'Message', 'Start_Time'], sortby_index=3)
```
那这个函数是怎么被调用的呢


在 `novaclient/shell.py` 的 `main` 里有

```python
# build available subcommands based on version
self.extensions = self._discover_extensions(
        options.os_compute_api_version)
```

然后找到这个函数

```python
def _discover_extensions(self, version):
    extensions = []
    for name, module in itertools.chain(
            self._discover_via_python_path(),
            self._discover_via_contrib_path(version),
            self._discover_via_entry_points()):

        extension = novaclient.extension.Extension(name, module)
        extensions.append(extension)

    return extensions
```

`self._discover_via_python_path()` 会找以 `python_novaclient_ext` 结尾的 module


```python
def _discover_via_contrib_path(self, version):
    module_path = os.path.dirname(os.path.abspath(__file__))
    version_str = "v%s" % version.replace('.', '_')
    ext_path = os.path.join(module_path, version_str, 'contrib')
    ext_glob = os.path.join(ext_path, "*.py")

    for ext_path in glob.iglob(ext_glob):
        name = os.path.basename(ext_path)[:-3]

        if name == "__init__":
            continue

        module = 
        yield name, module
```
其中 `glob.iglob(ext_glob)` 会生成一个 iterator 循环所有 `contrib/*.py`，`imp.load_source(name, ext_path)` 再加载 module。

最后载入 Entry Points `novaclient.extensions`，参考 http://stackoverflow.com/a/9615473
