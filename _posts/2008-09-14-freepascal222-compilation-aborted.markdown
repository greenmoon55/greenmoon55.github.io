---
author: admin
comments: true
date: 2008-09-14 03:04:02+00:00
layout: post
slug: freepascal222-compilation-aborted
title: FreePascal 2.2.2无法编译解决办法
wordpress_id: 78
categories:
- Programming
tags:
- FreePascal
---

2.2.2是今年8月11号更新的，没感觉到有什么新东西，可是装上之后无法编译。Google到了解决办法，不过现在忘记在哪里看到的了，应该是freepascal.org的社区里。

错误提示：


> Fatal: Unable to open file D:FPC2.2.2bini386-win32fp.cfg
Fatal: Compilation aborted


解决办法：删除安装目录下的fp.cfg即可，比如这个D:FPC2.2.2bini386-win32fp.cfg。 貌似Freepascal一有问题删掉配置文件就行。

[这是](http://bugs.freepascal.org/view.php?id=11864)freepascal里bugtracker的描述，应该就是这个问题。
