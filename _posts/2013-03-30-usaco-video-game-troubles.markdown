---
author: admin
comments: true
date: 2013-03-30 05:18:34+00:00
layout: post
slug: usaco-video-game-troubles
title: USACO Video Game Troubles
wordpress_id: 427
categories:
- Programming
---

BNUOJ 4140

有很多游戏平台，每个平台上有很多游戏，每个游戏有花费和价值。

这道题很有趣，要背包两次，先考虑要不要买某个游戏，再考虑要不要买某个游戏平台。

看了这个题解才明白的：http://blog.sina.com.cn/s/blog_4a0c4e5d010147j3.html

循环过每个平台所有游戏之后，再考虑购买游戏平台的花费，这时候转换为另一个背包问题，要不要买这个平台。

dp[j][k] 表示第i个（当前平台）考虑了j个游戏，预算为k时的最大价值。dp[0][k] 就是前i个平台，当前预算为k的最优值。。


```cpp 

#include 
#include 
#include 
using namespace std;
const int MAXN = 55;
const int MAXG = 15;
int p[MAXN];
int g[MAXN];
int gp[MAXN][MAXG], pv[MAXN][MAXG];
int dp[MAXN][100010];
int main()
{
    int n, v;
    while (scanf("%d%d", &n;, &v;)!=EOF)
    {
        memset(dp, 0, sizeof(dp));
        for (int i = 1; i <= n; i++)
        {
            scanf("%d", &p;[i]);
            scanf("%d", &g;[i]);
            for (int j = 1; j <= g[i]; j++)
            {
                scanf("%d%d", &gp;[i][j], &pv;[i][j]);
            }
        }
        for (int i = 1; i <= n; i++)
        {
            for (int j = 1; j <= g[i]; j++)
            {
                for (int k = v; k >= 0; k--)
                {
                    if (k >= gp[i][j]) dp[j][k] = max(dp[j-1][k], dp[j-1][k-gp[i][j]] + pv[i][j]);
                    else dp[j][k] = dp[j-1][k];
                }
            }

            for (int k = v; k >= p[i]; k--)
            {
                dp[0][k] = max(dp[0][k], dp[g[i]][k-p[i]]);
            }
        }
        printf("%d\n", dp[0][v]);
    }
    return 0;
}

```

