---
author: admin
comments: true
date: 2012-10-22 08:33:20+00:00
layout: post
slug: topcoder-srm-558-div-2
title: TopCoder SRM 558 DIV 2
wordpress_id: 406
categories:
- Programming
---

先吐个嘈。。这次题目太难了吧。。第二题整个房间没人交，第三题只有两个人交，而且都 Failed System Test...

250
略

600
读题很重要！读题很重要！又一次写好了才发现错误。。
dp[i][j]表示盖章到第i个字符，颜色为j，最少盖几次。细节很容易错= =

```cpp 

#include 
#include 
#include 
#include 
using namespace std;
const int MAX = 0x7f7f7f7f;
inline int min(const int &a;, const int &b;, const int &c;)
{
    cout << "min" << min(min(a, b), c)  << endl;
    return min(min(a, b), c);
}
class Stamp
{
    public:
    string str;
    int length;
    bool used[300];
    int getMinimumCost(string desiredColor, int stampCost, int pushCost)
    {
        str = desiredColor;
        length = desiredColor.size();
        int dp[55][4];
        int ans = MAX;
        for (int l = 1; l <= length; l++) // 章的长度为l
        {
            memset(used, 0, sizeof(used));
            memset(dp, 0x7f, sizeof(dp));
            for (int i = 0; i < l; i++)
            {
                used[str[i]] = true;
            }
            int sum = used['R'] + used['G'] + used['B'];
            if (sum <= 1)
            {
                if (sum == 0)
                {
                    dp[l - 1][1] = dp[l - 1][2] = dp[l - 1][3] = 1;
                }
                else
                {
                    if (used['R']) dp[l - 1][1] = 1;
                    else if (used['G']) dp[l - 1][2] = 1;
                    else if (used['B']) dp[l - 1][3] = 1;
                }
            }
            for (int i = l; i < length; i++) // 当前盖章到第i个字符（含）
            {
                // 0????????????
                for (int j = i - l; j < i; j++) // 上一个章到第j个字符（含）
                {
                    if (dp[j][1] == MAX && dp[j][2] == MAX && dp[j][3] == MAX) continue;
                    memset(used, 0, sizeof(used));
                    for (int k = i - l + 1; k <= i; k++)
                    {
                        used[str[k]] = true;
                    }
                    int sum = used['R'] + used['G'] + used['B'];
                    if (sum > 1)
                    {
                        continue;
                    }
                    if (j == i - l)
                    {
                        int temp = min(dp[j][1], dp[j][2], dp[j][3]) + 1;
                        if (sum == 0)
                        {
                            dp[i][1] = dp[i][2] = dp[i][3] = temp;
                        }
                        else
                        {
                            if (used['R']) dp[i][1] = temp;
                            else if (used['G']) dp[i][2] = temp;
                            else dp[i][3] = temp;//used['B']
                        }
                    }
                    else
                    {
                        if (sum == 0)
                        {
                            dp[i][1] = min(dp[i][1], dp[j][1] + 1);
                            dp[i][2] = min(dp[i][2], dp[j][2] + 1);
                            dp[i][3] = min(dp[i][3], dp[j][3] + 1);
                        }
                        else
                        {
                            if (used['R']) dp[i][1] = min(dp[i][1], dp[j][1] + 1);
                            else if (used['G']) dp[i][2] = min(dp[i][2], dp[j][2] + 1);
                            else dp[i][3] = min(dp[i][3], dp[j][3] + 1);
                        }
                    }
                }
            }
            if (min(dp[length - 1][1], dp[length - 1][2], dp[length - 1][3]) == MAX) continue;
            int temp = stampCost * l + min(dp[length - 1][1], dp[length - 1][2], dp[length - 1][3]) * pushCost;
            if (temp < ans) ans = temp;
        }
        return ans;
    }
};

```


900
通过[搜索](http://apps.topcoder.com/forums/?module=Thread&threadID=765870&start=0)，才知道这是一个经典博弈题，叫做 [The Game of Nim](http://community.topcoder.com/tc?module=Static&d1=tutorials&d2=algorithmGames)，异或一下就可以了，好神奇。

```cpp 

#include 
#include 
#include 
using namespace std;
class CatAndRabbit
{
    public:
    string getWinner(string tiles)
    {
        int length = tiles.size();
        bool hasBlack = false, hasWhite = false;
        for (int i = 0; i < length; i++)
        {
            if (tiles[i] == '#') hasBlack = true;
            else if (tiles[i] == '.') hasWhite = true;
        }
        if (!hasBlack || !hasWhite) return "Rabbit";
        int s = 0;
        while (tiles[s] == '#') ++s;
        int l = 0;
        int a[100], p = 0;
        while (s < length)
        {
            if (tiles[s] == '#')
            {
                if (tiles[s - 1] == '.')
                {
                    a[p++] = l;
                    l = 0;
                }
                else
                {
                    ++s;
                    continue;
                }
            }
            else ++l;
            ++s;
        }
        if (tiles[length - 1] == '.')
        {
            a[p++] = l;
        }
        int ans = 0;
        for (int i = 0; i < p; i++) ans = ans ^ a[i];
        if (ans == 0) return "Rabbit";
        else return "Cat";
    }
};

```

