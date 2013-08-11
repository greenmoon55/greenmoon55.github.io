---
author: admin
comments: true
date: 2008-03-30 12:18:34+00:00
layout: post
slug: upgrading-to-wordpress-25
title: WP升级到2.5
wordpress_id: 30
categories:
- Blogging
tags:
- Update
- Wordpress
---

昨天半夜（准确的说是今天），[我发现](http://fanfou.com/statuses/SEz7bqCTIDk)WP2.5正式版[放出来了](http://wordpress.org/development/2008/03/wordpress-25-brecker/)。刚才升级了，过程十分顺利。下面说一下（参考[http://codex.wordpress.org/Upgrading_WordPress](http://codex.wordpress.org/Upgrading_WordPress)）。



	
  1. 应该Deactive All Plugins，但是我忘了，结果没什么影响

	
  2. 备份数据库（用[WP-DBManager](http://wordpress.org/extend/plugins/wp-dbmanager/)）和所有文件

	
  3. 删除原来的wp-includes和`wp-admin文件夹`

	
  4. `上传新文件（不要覆盖wp-content文件夹，不用变）`

	
  5. `到wp-admin/upgrade.php点几下按钮就行了`


`我用的插件都没有兼容性问题。刚发现WP Grins好像不自动插入表情符号了。。 :(`

`感受：后台好看多了，写日志时编辑也快多了（比如插入链接），推荐升级，但事先一定做好备份。`

`下面是截图，用IE7不能插入。。只好用FF :D`

`[gallery]`
