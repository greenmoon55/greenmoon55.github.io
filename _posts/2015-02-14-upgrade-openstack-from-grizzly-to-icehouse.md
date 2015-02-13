---
layout: post
title: Upgrade Openstack From Grizzly To Icehouse
published: true
---

首先，我们在Meetup的时候介绍过升级，请看[这里](http://techshow.ctrip.com/archives/810.html)的Session 3。说到升级，想起Paris summit的一个视频：Upgrading in Place from Grizzly to Icehouse: A Cautionary Tale[https://www.openstack.org/summit/openstack-paris-summit-2014/session-videos/presentation/upgrading-in-place-from-grizzly-to-icehouse-a-cautionary-tale]，具体说什么没啥印象了，只记得里面那句吐槽：one developer, two weeks，事实证明不可能那么快= =

网上有很多种升级方案，例如[RDO的分类](https://openstack.redhat.com/Upgrading_RDO)就很不错。我们这边的环境对cloud的可用性要求不高，只要已经部署好的VM不受影响，可以接受较长时间不部署/管理虚拟机，所以我们最终选择了pdf里的方案一，就是controller原地升级，其实最后我们觉得换controller也不错...能降低点风险，还好升级时用方案一没遇到太多问题。

升级第一关就是db migration了，理论上来说上游代码里会考虑到升级的问题，每步db migration应该都在代码里面。其实这里还是有些问题的，我们有自己的改动，要先downgrade放弃自己的修改再upgrade，我们旧版上所有代码改动都先放弃了。。

首先就是grizzly的keystone client不支持降级（db sync指定版本），这个很好解决，改改代码咯。还有icehouse的nova db migration只支持从H版升上来，解决办法就是从H版把从G升到H的代码搞过来。。

难点在于neutron的db migration。I版的neutron经过重构，有了ml2 plugin，我们db sync之后还需要用官方提供的[migrate to ml2的脚本](https://github.com/openstack/neutron/blob/3116ffafdca72e9eef70f4eaf90626982ae51d4c/neutron/db/migration/migrate_to_ml2.py)来改数据库，以支持ml2 plugin。H版的neutron在建VM的时候会把host和port插入portbindingports表，migrate to ml2脚本就会从这个表读数据并插入到ml2_port_bindings表里，network segment的信息是由ovs_network_bindings表搞出来的。（待补充）。。

下面问题来了，portbindingports是H版才有的表，G版根本没有啊，从grizzly升上来也不会建这个表，这样migrate to ml2就会有问题。不过用ovs plugin跑起来没啥问题...最终我们的办法是在db sync之后，migrate to ml2之前把host和port插入进去，这样看起来数据ok！^_^ 网上没搜到这种问题，很奇怪。还有I版用ovs plugin的时候，如果是手工建的port，neutron不会插入到portbindingports里，migrate to ml2就不会插入ml2_port_bindings表里，但是ml2 plugin会把这种port插入ml2_port_bindings。Anyway，我们最后也把这种unbound的port都插入进去了。

以上就是db migration的问题，我们在测试升级和实际操作的时候还遇到一些问题。

1. mysql备份出来的sql，注释的地方也是有用的，不能随便删掉。

2. 更新包的时候有些包没有依赖，不会自动更新，要手动搞。

3. neutron agents由fqdn改成hostname，要删掉inactive的那些（这个文档也写了）

4. 太多坑了= =！

我们整个升级用时是估算时间*2...

下次升级一定要准备更充分一点，估计是升到Kilo或者Liberty了...最好neutron的代码也有人认真看看。其实I版上游的代码还有挺多bug的，要是有能力的话有很多机会贡献代码= =...

研究升级方案时发现有好多好多可以学的东西啊～之前一直有其他需求，没空搞升级，终于在年前搞定这件大事了。（似乎还有坑没发现T_T)


