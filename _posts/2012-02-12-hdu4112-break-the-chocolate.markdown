---
author: admin
comments: true
date: 2012-02-12 03:27:05+00:00
layout: post
slug: hdu4112-break-the-chocolate
title: HDU4112 Break the Chocolate
wordpress_id: 333
categories:
- Programming
tags:
- ACM
---

将N*M*K的巧克力分成1*1*1，用刀切可以同时切多块，用手掰每次只能将一块掰成两块。

思路：用刀切显然是log2(m)+log2(n)+log2(k)（每个都取上整），手掰的话，首先n-1次掰成n块，然后m-1次掰成m*n块，最后k-1次掰成m*n*k块，(n-1)+n*(m-1)+m*n*(k-1)，整理得m*n*k-1。后来看到一种想法，每掰一块多一个，所以就是m*n*k-1次。


```cpp 


#include 
#include 
#include 
using namespace std;

int ans(int n, int m, int k)
{
    return ceil(log(double(n))/log(2.0)) + ceil(log(double(m))/log(2.0)) + ceil(log(double(k))/log(2.0));
}
int main()
{
    int t;
    int n, m, k;
    cin >> t;
    for (int i = 1; i <= t; i++)
    {
        cin >> n >> m >> k;
        printf("Case #%d: %lld %d\n", i, (long long)n * m * k - 1, ans(n, m, k));
    }
    return 0;
}

```


写的时候把t和k弄混过......
还要注意用long long。
