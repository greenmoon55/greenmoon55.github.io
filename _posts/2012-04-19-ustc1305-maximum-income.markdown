---
author: admin
comments: true
date: 2012-04-19 16:20:22+00:00
layout: post
slug: ustc1305-maximum-income
title: USTC1305 Maximum income
wordpress_id: 358
categories:
- Programming
tags:
- 单调队列
---

来自 xw 和 wh：
维护一个递减的单调队列，因为后入队的数只有比前面所有的数小才有可能成为符合条件区间的起点，若不满足这个条件，就二分找当前最大区间。复杂度 nlogn。

===
最近好忙= =


```cpp 

#include 
#include 
#include 
using namespace std;
const int MAXN = 100010;
int a[MAXN];
int queue[MAXN];
int day[MAXN];
int main()
{
    int t;
    int n, c;
    int p, ans;
    cin >> t;
    while (t--)
    {
        scanf("%d%d", &n;, &c;);
        for (int i = 0; i < n; i++) scanf("%d", &a;[i]);

        queue[0] = a[0];
        day[0] = 0;
        p = 0;
        ans = 0;

        for (int i = 1; i < n; i++)
        {
            if (a[i] < queue[p])
            {
                queue[++p] = a[i];
                day[p] = i;
            }
            else
            {
                int l = 0, r = p;
                int mid;
                while (l < r)
                {
                    mid = (l + r)/2;
                    if (queue[mid] <= a[i])
                    {
                        r = mid;
                    }
                    else l = mid + 1;
                }
                if (i - day[l] > ans) ans = i - day[l];
            }
        }
        if (ans) ans = (++ans)*c;
        printf("%d\n", ans);
    }
    return 0;
}

```

