---
layout: post
title: Nova scheduler
published: true
---

Nova部署、迁移VM都会用到scheduler来调度。本文内容基于Icehouse。

#Filters and Weights

![Filters and Weights](http://greenmoon55.com/images/scheduler.png "Filters and Weights")

Filters会过滤不符合条件的宿主机，然后经过Weights获得权重，最终选择权重最大的host。

常用filter有RetryFilter,AvailabilityZoneFilter,RamFilter,ComputeFilter,ComputeCapabilitiesFilter,ImagePropertiesFilter。

默认启用的weighter只有RAMWeigher。。会返回host的可用内存，最终选取可用内存最大的host。

另外还有个MetricsWeigher，可以自定义各项metric的重要性，不过默认没有启用。

#Resource tracker

那么这些权重怎么获取呢？

nova/compute/manager.py 有个periodic task update_available_resource，每分钟会更新一次host的资源使用情况。最终会调用到resource tracker里的_sync compute node，更新compute_nodes表。scheduler里的HostManager再从数据库里获取metrics。

scheduler本身不会更新host metric，只会在filter_scheduler _provision_resource时更新instance的host, node及schedule_at。

#是否有cache
没有，有个caching scheduler，可缓存all_host_states，默认没有启用。

#retry如何实现？

filter scheduler -> def scheduler_run_instance -> def _schedule -> def _populate_retry

```python
retry = {
    'num_attempts': 1,
    'hosts': []  # list of compute hosts tried
}
filter_properties['retry'] = retry
```

compute/manager.py有_reschedule_or_error，如果失败会RPC调用scheduler。
另外有个RetryFilter，会过滤之前尝试（失败）过的host。

相关资料：

[Nova Scheduler Intel 王庆](http://www.openstack.cn/?p=3312)

[臭蛋 Nova Scheduler分析](http://www.choudan.net/2013/08/11/Nova-Scheduler%E5%88%86%E6%9E%90.html)

[Mirantis: Nova Scheduler-Database Interactions: How to Nail Those Scalability Thwarters](https://www.mirantis.com/blog/nova-scheduler-database-interactions-how-to-nail-those-scalability-thwarters/)
