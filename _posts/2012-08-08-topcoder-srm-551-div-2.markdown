---
author: admin
comments: true
date: 2012-08-08 06:06:05+00:00
layout: post
slug: topcoder-srm-551-div-2
title: TopCoder SRM 551 DIV 2
wordpress_id: 386
categories:
- Programming
tags:
- DP
---

250
略

500
枚举中心，然后两边往中间移，当时想错了= =

```cpp 

#include 
#include 
using namespace std;
class ColorfulChocolates
{
    public:
    int maximumSpread(string chocolates, int maxSwaps)
    {
        int ans = 1;
        for (int i = 0; i < chocolates.length(); i++)
        {
            int left = i - 1;
            int leftCount = 0;
            int rightCount = 0;
            int right = i + 1;
            char color = chocolates[i];
            int curSwaps = maxSwaps;
            int dis;
            while (left >= 0 || right < chocolates.length())
            {
                if (left >= 0 && chocolates[left] == color)
                {
                    dis = i - 1 - leftCount - left;
                    leftCount++;
                    curSwaps -= dis;
                    if (curSwaps < 0) break;
                    ans = max(ans, leftCount + rightCount + 1);
                }
                if (right < chocolates.length() && chocolates[right] == color)
                {
                    dis = right - (i + 1 + rightCount);
                    rightCount++;
                    curSwaps -= dis;
                    if (curSwaps < 0) break;
                    ans = max(ans, leftCount + rightCount + 1);
                }
                --left;
                ++right;
            }
        }
        return ans;
    }
};

```


950
DP
三种纸杯蛋糕，相邻的朋友得到的蛋糕不一样。
很容易想出dp[i][j][k][l]表示前i个朋友，发了j个A纸杯蛋糕，k个B纸杯蛋糕，第i个朋友的蛋糕种类为l。问题是怎么处理最后一个人和第一个不能相同呢，其实只要枚举第一个蛋糕是哪种，DP三次，然后处理最后一个人获得的蛋糕即可。

```cpp 

#include 
#include 
#include 
using namespace std;
const int MOD = 1000000007;
class ColorfulCupcakesDivTwo
{
    int dp[55][55][55][3];
    int length, count[3];
    public:
    void work()
    {
        for (int i = 1; i < length; i++)
        {
            for (int j = 0; j <= i; j++) // 用A的数量
            {
                for (int k = 0; k <= i - j; k++) // 用B的数量
                {
                    if (dp[i][j][k][0])
                    {
                        if (count[1] - k > 0) dp[i+1][j][k+1][1] = (dp[i+1][j][k+1][1] + dp[i][j][k][0]) % MOD;
                        if (count[2] - (i - j - k) > 0) dp[i+1][j][k][2] = (dp[i+1][j][k][2] + dp[i][j][k][0]) % MOD;
                    }
                    if (dp[i][j][k][1])
                    {
                        if (count[0] - j > 0) dp[i+1][j+1][k][0] = (dp[i][j][k][1] + dp[i+1][j+1][k][0]) % MOD;
                        if (count[2] - (i - j - k) > 0) dp[i+1][j][k][2] = (dp[i][j][k][1] + dp[i+1][j][k][2]) % MOD;
                    }
                    if (dp[i][j][k][2])
                    {
                        if (count[0] - j > 0) dp[i+1][j+1][k][0] = (dp[i][j][k][2] + dp[i+1][j+1][k][0]) % MOD;
                        if (count[1] - k > 0) dp[i+1][j][k+1][1] = (dp[i][j][k][2] + dp[i+1][j][k+1][1]) % MOD;
                    }
                }
            }
        }
    }
    int countArrangements(string cupcakes)
    {
        length = cupcakes.length();
        memset(count, 0, sizeof(count));
        for (int i = 0; i < length; i++)
        {
            ++count[cupcakes[i] - 'A'];
        }
        int ans = 0;
        if (count[0])
        {
            memset(dp, 0, sizeof(dp));
            dp[1][1][0][0] = 1;
            work();
            for (int j = 0; j <= length; j++)
            {
                for (int k = 0; k <= length - j; k++)
                {
                    ans = (ans + dp[length][j][k][1]) % MOD;
                    ans = (ans + dp[length][j][k][2]) % MOD;
                }
            }
        }
        if (count[1])
        {
            memset(dp, 0, sizeof(dp));
            dp[1][0][1][1] = 1;
            work();
            for (int j = 0; j <= length; j++)
            {
                for (int k = 0; k <= length - j; k++)
                {
                    ans = (ans + dp[length][j][k][0]) % MOD;
                    ans = (ans  + dp[length][j][k][2]) % MOD;
                }
            }
        }
        if (count[2])
        {
            memset(dp, 0, sizeof(dp));
            dp[1][0][0][2] = 1;
            work();
            for (int j = 0; j <= length; j++)
            {
                for (int k = 0; k <= length - j; k++)
                {
                    ans = (ans + dp[length][j][k][0]) % MOD;
                    ans = (ans + dp[length][j][k][1]) % MOD;
                }
            }
        }
        return ans;
    }
};

```

