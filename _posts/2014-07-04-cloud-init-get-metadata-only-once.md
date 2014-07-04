---
layout: post
title: 使cloud-init只读取一次metadata
published: true
---
只需配置`manual_cache_clean:False`，否则在init-local时会自动清除缓存，见[代码](https://github.com/number5/cloud-init/blob/d37e212159ee14ca859714a7473268717db93e88/bin/cloud-init#L233)。

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