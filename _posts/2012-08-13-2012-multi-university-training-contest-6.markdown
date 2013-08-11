---
author: admin
comments: true
date: 2012-08-13 11:00:58+00:00
layout: post
slug: 2012-multi-university-training-contest-6
title: 2012 Multi-University Training Contest 6
wordpress_id: 389
categories:
- Programming
---

官方题解：[2012 Multi-University Training Contest 6 Solution](http://page.renren.com/601081183/note/865145486)
1001 **Card**
int length = r - l + 1;
循环节的长度一定是LCM(r, length) / length，然后就好做了吧...代码里把lcm写成lcd了。

```cpp 

#include 
#include 
using namespace std;
inline int gcd(int a, int b)
{
    int t;
    while (b > 0)
    {
        t = a % b;
        a = b;
        b = t;
    }
    return a;
}
inline long long lcd(long long a, long long b)
{
    return a * b / gcd(a, b) ;
}
int main()
{
    int t, n, l, r;
    int card[55];
    int N = 52;
    scanf("%d", &t;);
    for (int caseno = 1; caseno <= t; caseno++)
    {
        for (int i = 1; i <= N; i++) scanf("%d", &card;[i]);
        scanf("%d%d%d",&n;, &l;, &r;);
        int length = r - l + 1;
        int loop = lcd(r, length) / length; // 循环节长度
        int shift = n % loop * length % r;
        shift = r - shift + 1;
        printf("Case #%d:", caseno);
        for (int i = shift; i <= r; i++) printf(" %d", card[i]);
        for (int i = 1; i < shift; i++) printf(" %d", card[i]);
        for (int i = r + 1; i <= N; i++) printf(" %d", card[i]);
        printf("\n");
    }
    return 0;
}

```


1006 **Party All the Time**
对于每个精灵，unhappiness都是与选定的聚会地相关的[凹函数](http://zh.wikipedia.org/zh-cn/%E5%87%B8%E5%87%BD%E6%95%B0)，而多个凹函数相加一定还是凹函数（貌似根据定义就可证），所以可以使用三分法。似乎这道题会有[精度问题](http://blog.ac521.org/?p=526)。

```cpp 

#include 
#include 
#include 
using namespace std;
const int MAXN = 50010;
const double eps = 1e-6;
double x[MAXN], w[MAXN];
int n;
double calc(double pos)
{
    double ans = 0;
    for (int i = 0; i < n; i++)
    {
        ans += w[i] * pow(fabs(x[i] - pos), 3);
    }
    return ans;
}

int main()
{
    int t;
    scanf("%d", &t;);
    for (int caseno = 1; caseno <= t; caseno++)
    {
        scanf("%d", &n;);
        for (int i = 0; i < n; i++) scanf("%lf%lf", &x;[i], &w;[i]);
        double left = x[0], right = x[n - 1];
        double leftmid, rightmid;
        double leftvalue, rightvalue;
        while (left + eps < right)
        {
            leftmid = (left + right) / 2;
            rightmid = (leftmid + right) / 2;
            leftvalue = calc(leftmid);
            rightvalue = calc(rightmid);
            if (leftvalue < rightvalue) right = rightmid;
            else left = leftmid;
        }
        printf("Case #%d: %.0lf\n", caseno, calc(left));
    }
    return 0;
} 

```


1008 **String change**
看官方题解吧。。这思路太神奇了。

1010 **Easy Tree DP?**
题中条件的意思是，左右子树中最大的元素一定在右子树。
搜到一篇题解，遗憾的是现在找不到了。。dp[i][j]表示用了i个节点，高度**小于等于**j的方案数。
dp[i][j] = i * (dp[i-1][j-1] * 2 + c[i-2][k] * dp[k][j-1] * dp[i-k-1][j-1])，k为左子树的节点数。

```cpp 

#include 
#include 
#include 
using namespace std;
const int MAXN = 365;
const int MOD = 1000000007;
int c[MAXN][MAXN];
long long dp[MAXN][MAXN];
int main()
{
    freopen("test.in", "r", stdin);
    int t, n, d;
    c[0][0] = 1;
    for (int i = 1; i < MAXN; i++)
    {
        c[i][0] = 1;
        for (int j = 1; j <= i; j++)
        {
            c[i][j] = (c[i - 1][j - 1] + c[i - 1][j]) % MOD;
        }
    }
    n = 360;
    memset(dp, 0, sizeof(dp));
    for (int i = 1; i <= n; i++) dp[1][i] = 1;
    for (int i = 2; i <= n; i++)
    {
        for (int j = 1; j <= n; j++)
        {
            dp[i][j] += 2 * dp[i-1][j-1] % MOD;
            dp[i][j] %= MOD;
            for (int k = 1; k < i - 1; k++)
            {
                dp[i][j] += c[i-2][k] * dp[k][j-1] % MOD * dp[i-1-k][j-1] % MOD;
                dp[i][j] %= MOD;
            }
            dp[i][j] *= i;
            dp[i][j] %= MOD;
        }
    }
    scanf("%d", &t;);
    for (int caseno = 1; caseno <= t; caseno++)
    {
        scanf("%d%d", &n;, &d;);
        printf("Case #%d: %lld\n", caseno, ((dp[n][d] - dp[n][d-1]) % MOD + MOD) % MOD);
    }
    return 0;
}

```

