---
author: admin
comments: true
date: 2013-03-30 06:04:23+00:00
layout: post
slug: 2013%e8%85%be%e8%ae%af%e7%bc%96%e7%a8%8b%e9%a9%ac%e6%8b%89%e6%9d%be%e5%88%9d%e8%b5%9b%e7%ac%ac%e3%80%87%e5%9c%ba
title: 2013腾讯编程马拉松初赛第〇场
wordpress_id: 428
categories:
- Programming
---

很遗憾，连复赛都没进。。cin 超时，一直没想到改成 scanf...


# 小Q系列故事——屌丝的逆袭


略


# 小明系列故事——买年货


dp[i][j][l][x] 表示前i个商品，剩余金额j，剩余积分l，剩余免费商品数x。
dp[i][j][l][x] = max(dp[i-1][j][l][x], dp[i-1][j][l][x+1] + val), dp[i-1][j][l+b][x] + val, dp[i-1][j+a][l][x] + val);

```cpp 

#include 
#include 
#include 
#include 
using namespace std;
int dp[110][110][110][6];
int main()
{
    int n, v1, v2, k;
    int a, b, val;
    while (scanf("%d%d%d%d", &n;, &v1;, &v2;, &k;)!= EOF)
    {
        memset(dp, 0, sizeof(dp));
        for (int i = 1; i <= n; i++)
        {
            scanf("%d%d%d", &a;, &b;, &val;);
            for (int j = 0; j <= v1; j++)
            {
                for (int l = 0; l <= v2; l++)
                {
                    for (int x = 0; x <= k; x++)
                    {
                        dp[i][j][l][x] = dp[i-1][j][l][x];
                        if (x < k) dp[i][j][l][x] = max(dp[i][j][l][x],
                            dp[i-1][j][l][x+1] + val);
                        if (l + b <= v2) dp[i][j][l][x] = max(dp[i][j][l][x],
                            dp[i-1][j][l+b][x] + val);
                        if (j + a <= v1) dp[i][j][l][x] = max(dp[i][j][l][x],
                            dp[i-1][j+a][l][x] + val);
                        //printf("%d %d %d %d %d\n", i,j,l,x,dp[i][j][l][x]);
                    }
                }
            }
        }
        printf("%d\n", dp[n][0][0][0]);
    }
    return 0;
}

```



# 吉哥系列故事——临时工计划


dp[i] 表示工作不超过第i天时获得的最多工资。先把工作按结束时间排序一下，然后你懂的。

```cpp 

#include 
#include 
#include 
#include 
using namespace std;
int dp[110][110][110][6];
int main()
{
    int n, v1, v2, k;
    int a, b, val;
    while (scanf("%d%d%d%d", &n;, &v1;, &v2;, &k;)!= EOF)
    {
        memset(dp, 0, sizeof(dp));
        for (int i = 1; i <= n; i++)
        {
            scanf("%d%d%d", &a;, &b;, &val;);
            for (int j = 0; j <= v1; j++)
            {
                for (int l = 0; l <= v2; l++)
                {
                    for (int x = 0; x <= k; x++)
                    {
                        dp[i][j][l][x] = dp[i-1][j][l][x];
                        if (x < k) dp[i][j][l][x] = max(dp[i][j][l][x],
                            dp[i-1][j][l][x+1] + val);
                        if (l + b <= v2) dp[i][j][l][x] = max(dp[i][j][l][x],
                            dp[i-1][j][l+b][x] + val);
                        if (j + a <= v1) dp[i][j][l][x] = max(dp[i][j][l][x],
                            dp[i-1][j+a][l][x] + val);
                        //printf("%d %d %d %d %d\n", i,j,l,x,dp[i][j][l][x]);
                    }
                }
            }
        }
        printf("%d\n", dp[n][0][0][0]);
    }
    return 0;
}

```



# 湫湫系列故事——植树节


这道题很有趣！！搜了题解才会，其实这道题是在求单色三角形的个数。详见[这里](http://noclyt.com/blog/?p=185)吧。。懒得画图说明了。


# 威威猫系列故事——篮球梦


每次攻击的时候 dp[i] = dp[i-1] + dp[i-2] + dp[i-3]，存的就是有多少种。。好多细节，略恶心，还有long long，如果数据不到一局且已经赢了，种数还是1。。

```cpp 

#include 
#include 
#include 
using namespace std;
int main()
{
    int a, b, t;
    while (cin >> a >> b >> t)
    {
        long long sum = 0;
        int defence = t / 30;
        int attack = t / 30 + t % 30 / 15;
        b += defence;
        int gap = b - a;
        if (attack * 3 <= gap) sum = 0;
        else if (attack == 0) sum = 1;
        else
        if (a + attack <= b)
        {
            long long dp[210];
            memset(dp, 0, sizeof(dp));
            dp[1] = dp[2] = dp[3] = 1;
            for (int i = 2; i <= attack; i++)
            {
                for (int j = 200; j >= 1; j--)
                {
                    dp[j] = 0;
                    if (j - 3 > 0) dp[j] += dp[j-3];
                    if (j - 2 > 0) dp[j] += dp[j-2];
                    if (j - 1 > 0) dp[j] += dp[j-1];
                }
            }
            for (int i = gap + 1; i <= 200; i++) sum += dp[i];
        }
        else
        {
            sum = 1;
            for (int i = 0; i < attack; i++) sum = sum * 3;
        }
        printf("%I64d\n", sum);
    }
    return 0;
}

```


