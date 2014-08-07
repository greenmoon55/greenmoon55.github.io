---
layout: post
title: 使 Cloud-init 只读取一次 Metadata
published: true
---
Linux 的 [cloud-init](https://launchpad.net/ubuntu/+source/cloud-init) 会在每次启动时运行，默认每次都会读取 metadata，如果 metadata service 挂掉了或者响应缓慢就会使虚拟机重启时花费很多时间，一般 metadata 也不会改变，Windows 上的 [cloudbase-init](http://www.cloudbase.it/cloud-init-for-windows-instances/) 貌似就只会读一次。

只需配置`manual_cache_clean:True`，否则在 init-local 时会自动清除缓存，见[代码](https://github.com/number5/cloud-init/blob/d37e212159ee14ca859714a7473268717db93e88/bin/cloud-init#L233)。

```python
        # The cache is not instance specific, so it has to be purged
        # but we want 'start' to benefit from a cache if
        # a previous start-local populated one...
        manual_clean = util.get_cfg_option_bool(init.cfg,
                                                'manual_cache_clean', False)
        if manual_clean:
            LOG.debug("Not purging instance link, manual cleaning enabled")
            init.purge_cache(False)
        else:
            init.purge_cache()
        # Delete the non-net file as well
        util.del_file(os.path.join(path_helper.get_cpath("data"), "no-net"))
```
