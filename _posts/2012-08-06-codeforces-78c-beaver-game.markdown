---
author: admin
comments: true
date: 2012-08-06 16:08:12+00:00
layout: post
slug: codeforces-78c-beaver-game
title: Codeforces 78C Beaver Game
wordpress_id: 382
categories:
- Programming
tags:
- Codeforces
- 博弈
---

[http://codeforces.com/problemset/problem/78/C](http://codeforces.com/problemset/problem/78/C)

n块木头，每块长度为m，两人对战（呃，其实是beaver），每人选一块木头并把它分为**长度相同**的多块，每块长度不得小于k，不能继续分者输。

貌似yds讲过类似的题，第一想法就是如果是偶数块木头，先手输，因为此时后手可以完全复制先手的策略，先手必输。如果有奇数块木头，那么先手应该选一块，把它直接分成不可分割的各小块，这样问题转化成前一种情况（此时先手相当于新情况的后手）。如果不可分割先手直接输，否则胜。

于是从2到sqrt(m)枚举**分成多少块**即可，注意特殊情况：k=1时一定可分割。


```cpp 

#include 
#include 
#include 
using namespace std;
int main()
{
    int n, m, k;
    bool split = false;
    cin >> n >> m >> k;
    int temp = sqrt(m);
    for (int i = 2; i <= temp; i++) if (m % i == 0 && m / i >= k)
    {
        split = true;
        break;
    }
    if (k == 1 && m > 1) split = true;
    if (split && n % 2) puts("Timur");
    else puts("Marsel");
    return 0;
} 

```


现在应该去做比赛的...刚才犹豫了一下没去做，于是睡觉去吧= =
