---
author: admin
comments: true
date: 2012-11-06 12:11:15+00:00
layout: post
slug: install-ruby-on-rails-on-ubuntu-12-10
title: Ruby on Rails 环境配置
wordpress_id: 408
categories:
- Software
---

**Updated @ 2013/3/21 21:21**




  1. 下载 RVM (Ruby Version Manager)


在终端里执行


> 
curl -L https://get.rvm.io | bash -s stable



可能需要先安装 curl


  2. 关闭当前打开的终端窗口，重新打开


  3. 执行
  4. 


> sudo apt-get install build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion pkg-config



  5. 安装 Ruby 2.0.0

输入


> 
rvm install 2.0.0



请耐心等待，可以出去转一圈或者睡一觉了...

  6. 点击终端的“编辑”菜单，选择“配置文件首选项”，切换到“标题和命令”选项卡，选择“以登录Shell方式运行命令”，然后重启终端



  7. 输入



> rvm 2.0.0 --default


如果没有任何显示，应该是正常的。
此时输入


> ruby -v


应该会显示 ruby 的版本号。


  8. 由于某些原因，我们使用淘宝的 [Rubygems 镜像](http://ruby.taobao.org/)



> 
gem source -r http://rubygems.org/
gem source -a http://ruby.taobao.org




  9. 安装rails



> 
gem install rails





至少需要半小时吧...
