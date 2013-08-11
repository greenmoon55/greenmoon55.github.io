---
author: admin
comments: true
date: 2012-04-14 15:39:19+00:00
layout: post
slug: hdu4193-non-negative-partial-sums
title: HDU4193 Non-negative Partial Sums
wordpress_id: 353
categories:
- Programming
tags:
- 单调队列
---

[HDU4193](http://acm.hdu.edu.cn/showproblem.php?pid=4193) 
终于知道单调队列了！其实挺简单的。搜到了这个：[补缺补漏：单调队列- Blog of Felix021 - TechOnly](http://www.felix021.com/blog/read.php?1965)

因为每个元素最多入队出队一次，所以复杂度是O(n)的。

这道题怎么做呢？开一个 2n 的数组，sum[i] 记录 a[1] 到 a[i] 的和。若在某个长度为 n 的区间里的最小 sum 大于等于区间左侧的 sum，也就是说区间里没有负数，答案计数加一。


```cpp 

// cin 会超时，不用 deque 会快一点
#include 
#include 
#include 
using namespace std;
const int MAXN = 2000010;
int a[MAXN];
int main()
{
    int n;
    while (scanf("%d", &n;))
    {
        if (n == 0) break;
        for (int i = 1; i <= n; i++)
        {
            scanf("%d", &a;[i]);
            a[i+n] = a[i];
        }
        for (int i = 1; i <= n*2; i++)
        {
            a[i] += a[i-1];
        }

        deque q;
        int ans = 0;
        for (int i = 1; i <= n*2; i++)
        {
            while (!q.empty() && a[q.back()]>=a[i]) q.pop_back();
            q.push_back(i);
            if (i > n && a[i - n] <= a[q.front()]) ++ans;
            if (!q.empty() && i - q.front() >= n - 1) q.pop_front();
        }
        printf("%d\n", ans);
    }
    return 0;
}

```


===
还有一些问题



  
  1. 单调队列的英文是什么

  
  2. 队尾去掉元素的时候等号可以不考虑吧，貌似那个文章有很多问题...

  
  3. 好像还有什么，突然忘了...


