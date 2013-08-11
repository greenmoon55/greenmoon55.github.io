---
author: admin
comments: true
date: 2012-07-28 13:20:29+00:00
layout: post
slug: 2012-multi-university-training-contest-2
title: 2012 Multi-University Training Contest 2
wordpress_id: 378
categories:
- Programming
tags:
- DP
- 最短路
---

官方题解：[http://blog.renren.com/blog/601081183/862977450](http://blog.renren.com/blog/601081183/862977450)

**1001 Hero**
[HDU4310](http://acm.hdu.edu.cn/showproblem.php?pid=4310)
每个英雄都有HP和DPS，玩家有无穷HP，DPS为1。每回合玩家选择一个英雄攻击，该英雄HP减一，同时玩家HP减去当前活着的英雄的DPS和。问如何攻击对手，损失HP最少。
官方题解上写的是状态压缩DP，其实当时看那么多人都过了，果断贪心，按DPS/HP递减排序攻击就行，我感觉这个贪心是对的吧。。


> 用dp[mask]表示杀死mask集合的敌人时，这些敌人造成的最小hp消耗。有转移方程dp[mask] = min{dp[mask - {i}] + hp_sum[mask] * dps[i], for all i in mask}


额，相当于先攻击后那个{i}。

```cpp 

#include 
#include 
#include 
using namespace std;
int dp[1 << 20];
int getdps(int x, int *dps)
{
    int ans = 0;
    int i = 1;
    int p = 0;
    while (i <= x)
    {
        if (x & i)
        {
            ans += dps[p];
        }
        i = i << 1;
        ++p;
    }
    return ans;
}
int main()
{
    int n;
    int dps[25], hp[25];
    while (cin >> n)
    {
        memset(dp, 127, sizeof(dp));
        dp[0] = 0;
        for (int i = 0; i < n; i++) cin >> dps[i] >> hp[i];
        for (int i = 1; i < (1 << n); i++)
        {
            int j = 1;
            int p = 0;
            int dpssum = getdps(i, dps);
            while (j <= i)
            {
                int temp = j ^ i;
                dp[i] = min(dp[i], dp[temp] + dpssum * hp[p]);
                j = j << 1;
                ++p;
            }
        }
        cout << dp[(1 << n) - 1] << endl;
    }
    return 0;
}

```


**1002 Meeting point-1**
[HDU4311](http://acm.hdu.edu.cn/showproblem.php?pid=4311)
用坐标表示每个人的住处，只能上下左右走。选择一个住处聚会，使所有人到达这里的距离和最小。
刚开始也是没思路，后来xw说，可以分别算x和y方向的距离，先按x排序，算出其他点到第一个点x方向的距离和（sumx[0]），然后递推算出每一个sumx，再按y排序，算出每个sumy。index记录到底是哪个点。

```cpp 

#include 
#include 
#include 
#include 
const int MAXN = 100010;
using namespace std;
struct point
{
    int x, y, index;
}px[MAXN], py[MAXN];
long long sumx[MAXN], sumy[MAXN];
long long ans[MAXN];
bool compx(const point &a;, const point &b;)
{
    return a.x < b.x;
}
bool compy(const point &a;, const point &b;)
{
    return a.y < b.y;
}
int main()
{
    int t, n;
    cin >> t;
    while(t--)
    {
        cin >> n;
        memset(sumx, 0, sizeof(sumx));
        memset(sumy, 0, sizeof(sumy));
        memset(ans, 0, sizeof(ans));
        for (int i = 0; i < n; i++)
        {
            scanf("%d%d", &px;[i].x, &px;[i].y);
            px[i].index = i;
            py[i] = px[i];
        }
        sort(px, px+n, compx);
        sort(py, py+n, compy);

        for (int i = 1; i < n; i++)
        {
            sumx[0] += px[i].x - px[0].x;
            sumy[0] += py[i].y - py[0].y;
        }
        ans[px[0].index] += sumx[0];
        ans[py[0].index] += sumy[0];
        for (int i = 1; i < n; i++)
        {
            sumx[i] = sumx[i-1] + (px[i].x - px[i-1].x) * (long long)(2*i - n);
            sumy[i] = sumy[i-1] + (py[i].y - py[i-1].y) * (long long)(2*i - n);
            //sumx[i] = sumx[i-1] - (px[i].x - px[i-1].x) * (n - i) + ;
            //sumy[i] = sumy[i-1] - (py[i].y - py[i-1].y) * (n - i);
            ans[px[i].index] += sumx[i];
            ans[py[i].index] += sumy[i];
        }
        /*
        cout <<"sumx" << endl;
        for (int i = 0; i < n; i++) cout << sumx[i] << endl;
        cout << "sumy" << endl;
        for (int i = 0; i < n; i++) cout << sumy[i] << endl;
        */

        long long bestans = 999999999999999LL;
        for (int i = 0; i < n; i++)
        {
            if (ans[i] < bestans) bestans = ans[i];
        }
        cout << bestans << endl;
    }
    return 0;
}

```


**Meeting point-2**
[HDU4312](http://acm.hdu.edu.cn/showproblem.php?pid=4312)
和上一道题的意思基本一样，这次可以斜着走，斜着走距离仍为1而不是根号二。
看了题解才知道，原来还有[切比雪夫距离](http://zh.wikipedia.org/wiki/%E5%88%87%E6%AF%94%E9%9B%AA%E5%A4%AB%E8%B7%9D%E7%A6%BB)、[曼哈顿距离](http://zh.wikipedia.org/zh-cn/%E6%9B%BC%E5%93%88%E9%A0%93%E8%B7%9D%E9%9B%A2)。


> 对于原坐标系中两点间的 Chebyshev 距离，是将坐标轴顺时针旋转45度并将所有点的坐标值放大sqrt(2)倍所得到的新坐标系中的Manhattan距离的二分之一。


这个挺神奇的，现在曼哈顿距离为2的两个点在原坐标系里切比雪夫距离为1。新坐标为 (x-y, x+y)，怎么算的呢？转换成极坐标然后就能算了，刚才我都忘了= =然后还用上道题的代码就可以了。

```cpp 

#include 
#include 
#include 
#include 
const int MAXN = 100010;
using namespace std;
struct point
{
    long long x, y;
    int index;
}px[MAXN], py[MAXN];
long long sumx[MAXN], sumy[MAXN];
long long ans[MAXN];
bool compx(const point &a;, const point &b;)
{
    return a.x < b.x;
}
bool compy(const point &a;, const point &b;)
{
    return a.y < b.y;
}
int main()
{
    int t, n;
    cin >> t;
    while(t--)
    {
        cin >> n;
        memset(sumx, 0, sizeof(sumx));
        memset(sumy, 0, sizeof(sumy));
        memset(ans, 0, sizeof(ans));
        long long tempx, tempy;
        for (int i = 0; i < n; i++)
        {
            //cin >> tempx >> tempy;
            scanf("%I64d%I64d", &tempx;, &tempy;);
            px[i].index = i;
            px[i].x = tempx - tempy;
            px[i].y = tempx + tempy;
            py[i] = px[i];
        }
        sort(px, px+n, compx);
        sort(py, py+n, compy);

        for (int i = 1; i < n; i++)
        {
            sumx[0] += px[i].x - px[0].x;
            sumy[0] += py[i].y - py[0].y;
        }
        ans[px[0].index] += sumx[0];
        ans[py[0].index] += sumy[0];
        for (int i = 1; i < n; i++)
        {
            sumx[i] = sumx[i-1] + (px[i].x - px[i-1].x) * (long long)(2*i - n);
            sumy[i] = sumy[i-1] + (py[i].y - py[i-1].y) * (long long)(2*i - n);
            ans[px[i].index] += sumx[i];
            ans[py[i].index] += sumy[i];
        }
        long long bestans = 999999999999999LL;
        for (int i = 0; i < n; i++)
        {
            if (ans[i] < bestans) bestans = ans[i];
        }
        cout << bestans / 2 << endl;
    }
    return 0;
}

```

**1004 Matrix**
[HDU4313](http://acm.hdu.edu.cn/showproblem.php?pid=4313)
一棵树上有K个机器，要使这K个机器互不相连，使去掉的边的权值和最小。
类似于Kruskal求最小生成树，边由大到小排序，如果某条边使两个机器连通就放弃这条边。因为其它的边一定比这条边长。

```cpp 

#include 
#include 
#include 
#include 
using namespace std;
const int MAXN = 100010;
struct e
{
    int u, v, w;
}edge[MAXN];

int p[MAXN], rank[MAXN];
bool machine[MAXN];
int n;

bool comp(const e &a;, const e &b;)
{
    return a.w > b.w;
}

void make_set()
{
    for (int i = 0; i < n; i++) // ?
    {
        p[i] = i;
        rank[i] = 0;
    }
}

int find_set(int x)
{
    if (x != p[x]) p[x] = find_set(p[x]);
    return p[x];
}

long long kruskal(int edgecount)
{
    int x, y;
    long long ans = 0;
    make_set();
    sort(edge, edge + edgecount, comp);
    for (int i = 0; i < edgecount ; i++)
    {
        x = find_set(edge[i].u);
        y = find_set(edge[i].v);
        if (machine[x] && machine[y]) continue;
        if (machine[x] || machine[y])
            machine[x] = machine[y] = true;
        if (x != y)
        {
            ans += edge[i].w;
            if (rank[x] > rank[y]) p[y] = x;
            else
            {
                p[x] = y;
                if (rank[x] == rank[y]) rank[y]++;
            }
        }
    }
    return ans;
}
int main()
{
    int t, k;
    cin >> t;
    while (t--)
    {
        cin >> n >> k;
        long long totaldis = 0;
        for (int i = 0; i < n - 1; i++)
        {
            scanf("%d%d%d", &edge;[i].u, &edge;[i].v, &edge;[i].w);
            totaldis += edge[i].w;
        }
        memset(machine, 0, sizeof(machine));
        for (int i = 0; i < k; i++)
        {
            int temp;
            scanf("%d", &temp;);
            machine[temp] = true;
        }
        cout << totaldis - kruskal(n - 1) << endl;
    }
    return 0;
}

```


**1009 Power transmission**
[HDU4318](http://acm.hdu.edu.cn/showproblem.php?pid=4318)
送电，每个边都有一个损耗的百分比，经过之后就会损失一些电能，每个点不能重复路过，从起始点到终点求一条损耗最小的路。
刚开始还搜索。。显然会TLE，后来xw有个小错误没写完。Dijkstra最短路，dist数组里存走到某个点剩下的百分比，每次选最大的。

```cpp 

#include 
#include 
#include 
#include 
using namespace std;
const int MAXN = 50010;
double dis[MAXN][55];
int edge[MAXN][55];
int t;
bool used[MAXN];
double dist[MAXN];

int main()
{
    int n;
    int s;
    double m;
    while (cin >> n)
    {
        memset(dist, 0, sizeof(dist));
        for (int i = 1; i <= n; i++)
        {
            scanf("%d", &edge;[i][0]);
            int temp;
            for (int j = 1; j <= edge[i][0]; j++)
            {
                scanf("%d%d", &edge;[i][j], &temp;);
                dis[i][j] = 1 - temp * 0.01;
            }
        }
        cin >> s >> t >> m;
        dist[s] = 1;
        memset(used, 0, sizeof(used));
        int nodenow;
        double mindis;
        for (int i = 1; i <= n; i++)
        {
            mindis = 0;
            for (int j = 1; j <= n; j++) if (!used[j] && dist[j] > mindis)
            {
                mindis = dist[j];
                nodenow = j;
            }
            if (fabs(mindis) < 1e-6) break;
            used[nodenow] = true;
            if (nodenow == t) break;
            for (int j = 1; j <= edge[nodenow][0]; j++)
            {
                int newnode = edge[nodenow][j];
                double temp = dist[nodenow] * dis[nodenow][j];
                if (!used[newnode] && temp > dist[newnode]) dist[newnode] = temp;
            }
        }
        if (used[t]) printf("%.2lf\n", m * (1 - dist[t]));
        else puts("IMPOSSIBLE!");
    }
    return 0;
}

```

