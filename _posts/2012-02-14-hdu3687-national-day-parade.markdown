---
author: admin
comments: true
date: 2012-02-14 13:41:59+00:00
layout: post
slug: hdu3687-national-day-parade
title: HDU3687 National Day Parade
wordpress_id: 339
categories:
- Programming
tags:
- ACM
---

国庆游行，学生们本来排成n*n的队形，休息时他们仅左右移动，现在求在什么位置恢复n*n队形，使所有学生当前位置到目标位置的距离的和最短。
n<=56,m<=200，左上角为(1, 1)，右下角为(n, m)，每位学生的位置 1<=Xi<=n,1<= Yi<=m

最开始以为是平均数，后来发现就是枚举目标位置。
每行一个vector，存该行点的y坐标。读入后排序，然后枚举队伍最左边的那一列。


```cpp 

#include 
#include 
#include 
#include 
using namespace std;

const int MAX = 2147483647;

int main()
{
    int n, m;
    int a, b;
    int count;
    while (true)
    {
        cin >> n >> m;
        if (!n && !m) break;
        vector line[60];
        count = n * n;

        while (count--)
        {
            cin >> a >> b;
            line[a].push_back(b);
        }
        for (int i = 1; i <= n; i++) sort(line[i].begin(), line[i].end());

        int sum, ans = MAX;
        //起始位置
        for (int i = 1; i <= m - n; i++)
        {
            sum = 0;
            //行
            for (int j = 1; j <= n; j++)
            {
                //列
                for (int k = 0; k < n; k++)
                sum += abs(line[j][k] - i - k); //-(i+k)
            }
            if (sum < ans) ans = sum;
        }
        cout << ans << endl;
    }
    return 0;
}

```

