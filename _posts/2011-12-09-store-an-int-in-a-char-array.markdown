---
author: admin
comments: true
date: 2011-12-09 13:40:08+00:00
layout: post
slug: store-an-int-in-a-char-array
title: 用字符数组存int
wordpress_id: 324
categories:
- Programming
tags:
- C++
---

[EUYUIL](http://euyuil.com)告诉我可以用字符数组存int。挺好玩。

    
    
    unsigned char test[100];
    memset(test, 0, sizeof(test));
    int a = 2147483647;
    int *p = (int*)&test;
    *p = a;
    int b = *p;
    cout << b << endl;
    
    ```
    
    此时test数组为{255, 255, 255, <strong>127</strong>, 0...}
    当然，如果a是1的话，test就是{1, 0, 0, 0, 0...}
    这是VS2010编译的结果。。不知道其他编译器其他平台结果怎么样。。
    
    刚刚在stackoverflow搜到<a href="http://stackoverflow.com/questions/1522994/store-an-int-in-a-char-array" title="Store an int in a char array?">这个问题</a>，以后有空再看看吧。
    
    总感觉我C++好弱，指针几乎没用过= =
    
    Update @ 2011/12/13 23:39
    如果放入TCHAR里，就是{65535, 32767, ...}。
