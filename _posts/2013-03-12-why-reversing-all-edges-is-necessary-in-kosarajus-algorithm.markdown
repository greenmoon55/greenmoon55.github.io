---
author: admin
comments: true
date: 2013-03-12 12:13:59+00:00
layout: post
slug: why-reversing-all-edges-is-necessary-in-kosarajus-algorithm
title: 为什么 Kosaraju 算法一定要把所有边反向
wordpress_id: 421
categories:
- Programming
---

[算法课](https://www.coursera.org/course/algo)上介绍说，[Kosaraju 算法](http://en.wikipedia.org/wiki/Kosaraju's_algorithm)的大概步骤是



  
  1. DFS反向图，记录每个点的出栈顺序

  
  2. 逆序（出栈顺序）遍历，找到所有的强连通分量


正确性证明略...见课程 PDF...

很自然地想到一个问题...为什么不能在原图 DFS，然后顺序遍历呢？

想想证明里的那个例子，从强连通分量 SCC1 到 SCC2 有一条边，反向之后DFS，能保证最后出栈的点一定在 SCC2 中，因此第二次 DFS 时能找到正确的结果。如果在原图 DFS，则不能保证第一个出栈的点在哪里...呃，很简单嘛...

比如说 A->B，B->A, A->C 这个图，如果出栈顺序是BAC就杯具了= =

其实这个例子是网上搜到的...

