---
author: admin
comments: true
date: 2012-08-13 10:19:23+00:00
layout: post
slug: 2012-multi-university-training-contest-5
title: 2012 Multi-University Training Contest 5
wordpress_id: 388
categories:
- Programming
---

官方题解：[2012 Multi-University Training Contest 5 Solution](http://page.renren.com/601081183/note/864816900)

1003 **Gold miner**
分组背包，详见《[背包问题九讲](http://cuitianyi.com/blog/%E3%80%8A%E8%83%8C%E5%8C%85%E9%97%AE%E9%A2%98%E4%B9%9D%E8%AE%B2%E3%80%8B2-0-alpha1/)》。
用点积判断是否在一条直线上。

```cpp 

#include 
#include 
#include 
#include 
using namespace std;
const int MAXN = 210;
struct gold
{
    int x, y, t, v;
}g[MAXN];
int dp[40010];
bool sameGroup(int a, int b)
{
    return g[a].x * g[b].y == g[b].x * g[a].y;
}
bool comp(const gold &a;, const gold &b;)
{
    return a.y < b.y;
}
int main()
{
    int n, t;
    int group[MAXN][MAXN];
    int caseno = 0;
    while (scanf("%d%d", &n;, &t;)!= EOF)
    {
        int groupCount = 0;
        memset(group, 0, sizeof(group));
        for (int i = 0; i < n; i++)
            scanf("%d%d%d%d", &g;[i].x, &g;[i].y, &g;[i].t, &g;[i].v);
        sort(g, g + n, comp);
        for (int i = 0; i < n; i++)
        {
            bool found = false;
            for (int j = 1; j <= groupCount; j++)
            {
                if (sameGroup(i, group[j][1]))
                {
                    gold* prev = &g;[group[j][group[j][0]]];
                    ++group[j][0];
                    group[j][group[j][0]] = i;
                    g[i].t += prev->t;
                    g[i].v += prev->v;
                    found = true;
                    break;
                }
            }
            if (found) continue;
            ++groupCount;
            ++group[groupCount][0];
            group[groupCount][1] = i;
        }
        memset(dp, 0, sizeof(dp));
        for (int i = 1; i <= groupCount; i++)
        {
            for (int time = t; time >= 0; time--)
            {
                for (int j = 1; j <= group[i][0]; j++)
                {
                    //if (time - g[group[i][j]].t < 0) break;
                    if (time - g[group[i][j]].t >= 0)
                    dp[time] = max(dp[time], dp[time - g[group[i][j]].t]
                                      + g[group[i][j]].v);
                }
            }
        }
        printf("Case %d: %d\n", ++caseno, dp[t]);
    }
    return 0;
}

```


1004 **History repeat itself**
不停地求sqrt(N)，得到比N小的新平方数的个数，然后加上这个数，直到找不到新的平方数为止。此时正好有N个非平方数（新加的数都是平方数）。然后可以很方便地推出公式求和。

```cpp 


#include 
#include 
#include 
using namespace std;
int main()
{
    int t, n;
    cin >> t;
    while (t--)
    {
        scanf("%d", &n;);
        long long m = n;
        long long add = sqrt(m);
        long long count = 0;
        while (add)
        {
            m += add;
            count += add;
            add = sqrt(m) - count;
        }
        cout << m << " ";
        long long x = count - 1;
        cout << x * (x+1) * (2*x+1)/3+(x+x*x)/2 + (m - count*count + 1) * count << endl;
    }
    return 0;
}

```


1007 **Permutation**
很容易想到这道题其实就是求，一些数相加和为N，它们的最小公倍数有多少种情况。遗憾的是没往下想，直接想DP没思路。
官方题解：由于1不影响最小公倍数，问题转化为相加小于等于N的若干正整数的最小公倍数的可能数。
再考虑，如果两个数不互质，最小公倍数与少一些因子变得互质的情况相同。所以只要考虑这些正整数是质数即可，注意每个数可能出现多次。
dp[i][j]表示前i种质数，构成和为j有多少种情况。
dp[i][j] = dp[i-1][j] + dp[i-1][j-k*prime[i]]

```cpp 


#include 
#include 
#include 
#include 
using namespace std;
long long dp[1010][1010];
int main()
{
    int n, primeCount = 0;
    int p[1000];
    for (int i = 2; i < 1010; i++)
    {
        int s = sqrt(i);
        bool prime = true;
        for (int j = 2; j <= s; j++)
        {
            if (i % j == 0)
            {
                prime = false;
                break;
            }
        }
        if (prime) p[++primeCount] = i;
    }
    int temp;
    while (scanf("%d", &n;) != EOF)
    {
        memset(dp, 0, sizeof(dp));
        for (int i = 0; i <= primeCount; i++) dp[i][0] = 1;
        long long ans = 0;
        for (int i = 1; i <= primeCount; i++)
        {
            if (n - p[i] < 0)
            {
                for (int j = 0; j <= n; j++) ans += dp[i-1][j];
                break;
            }
            temp = p[i];
            for (int j = n; j > 0; j--)
            {
                dp[i][j] = dp[i - 1][j];
            }
            while (n - temp >= 0)
            {
                for (int j = n; j > 0; j--)
                {
                    if (j - temp < 0) break;
                    dp[i][j] += dp[i - 1][j - temp];
                }
                temp *= p[i];
            }
        }
        cout << ans << endl;
    }
    return 0;
}

```


1011 **Xiao Ming's Hope**
找规律，这题我用cin居然超时，不知道为什么。

```cpp 

#include 
#include 
using namespace std;
int main()
{
    int n;
    while (scanf("%d", &n;) != EOF)
    {
        int count = 0;
        do
        {
            if (1 & n) ++count;
            n >>= 1;
        } while(n);
        printf("%d\n", 1 << count);
    }
    return 0;
}

```

