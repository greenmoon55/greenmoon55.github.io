---
author: admin
comments: true
date: 2012-08-04 03:53:21+00:00
layout: post
slug: zoj-monthly-july-2012
title: ZOJ Monthly, July 2012
wordpress_id: 380
categories:
- Programming
tags:
- DP
---

[118 - ZOJ Monthly, July 2012](http://acm.zju.edu.cn/onlinejudge/showContestProblems.do?contestId=339)
A **Magic Number**
找规律

B **Battle Ships**
敌人生命值为l，我们有n个船，每个船可以造无限个，造船时间为t[i]，攻击力为attack[i]。
dp[i][j]表示攻击敌人i个生命值，当前攻击力为j时的时间最小花费。
dp[i + j * t[k]][j + attack[k]] =  min(dp[i + j * t[k]][j + attack[k]], dp[i][j] + t[k])
比赛时想出来这个挺爽的，不过接下来就没出题目...

```cpp 

#include 
#include 
#include 
#include 
using namespace std;
const int INF = 0x7f7f7f7f;
const int POWERMAX = 330;
int main()
{
    int n, l;
    int dp[350][350];
    int t[50], attack[50];
    while (cin >> n >> l)
    {
       memset(dp, 127, sizeof(dp));
        for (int i = 0; i < n; i++)
        {
            scanf("%d%d", &t;[i], &attack;[i]);
        }
        dp[0][0] = 0;
        int ans = INF;
        for (int i = 0; i < l; i++)
        {
            for (int j = 0; j <= POWERMAX; j++)
            {
                if (dp[i][j] == INF) continue;
                for (int k = 0; k < n; k++)
                {
                    if (j + attack[k] <= POWERMAX)
                    {
                        if (i + j * t[k] < l)
                        dp[i + j * t[k]][j + attack[k]] =  min(dp[i + j *t[k]][j + attack[k]], dp[i][j] + t[k]);
                    }
                    if (j == 0) continue;
                    if (i + j >= l)
                    {
                        ans = min(ans, dp[i][j] + 1);
                    }
                    else
                    {
                        dp[i+j][j] = min(dp[i+j][j], dp[i][j] + 1);
                    }
                }
            }
        }
        cout << ans << endl;
    }
    return 0;
}

```


E **Treasure Hunt I**
一棵树，某人从一点出发，在限定的时间内返回，求最大收益。
简单的树形DP，这种题目很少写，非常不熟练。dp[node][j]表示**刚好**用j个单位时间遍历node获得的最大值，具体思路见代码，j要递减，保证dp[node][j-l-map[node][i]*2]表示从node出发，走0到i-1节点后获得的最大值，

```cpp 

#include 
#include 
#include 
using namespace std;
const int MAXN = 105;
const int INF = 0x7f7f7f7f;
int v[MAXN];
int map[MAXN][MAXN];
int dp[MAXN][205];
int n, k, m;
void dfs(int node)
{
    dp[node][0] = v[node];
    for (int i = 1; i <= n; i++)
    {
        if (map[node][i] == INF) continue;
        if (dp[i][0] >= 0) continue;
        dfs(i);
        for (int j = m; j > 0; j--)
        {
            for (int l = 0; l + map[node][i] * 2 <= j; l++)
            dp[node][j] = max(dp[node][j], dp[i][l] + dp[node][j-l-map[node][i]*2]);
        }
    }
}
int main()
{
    while (cin >> n)
    {
        for (int i = 1; i <= n; i++) scanf("%d", &v;[i]);
        int u, v, w;
        memset(map, 127, sizeof(map));
        memset(dp, -1, sizeof(dp));
        for (int i = 1; i < n; i++)
        {
            scanf("%d%d%d", &u;, &v;, &w;);
            map[u][v] = map[v][u] = w;
        }
        cin >> k >> m;
        dfs(k);
        int ans = 0;
        for (int i = 0; i <= m; i++) ans = max(ans, dp[k][i]);
        cout << ans << endl;
    }
    return 0;
}

```


H **Treasure Hunt IV**
找规律，刚开始没发现和平方有关，交上去TLE，囧。

```cpp 

#include 
#include 
#include 
using namespace std;
bool work(int x)
{
    int sum = 0;
    for (int i = 1; i <= x; i++) sum += x / i;
    if (sum % 2) return false;
    return true;
}
long long getans(long long x)
{
    long long a = sqrt(x);
    if (a % 2 == 0) return a / 2 * (a - 1) + x - a * a + 1;
    else return (a + 1) / 2 * a;
}
int main()
{
    long long a, b;
    while (cin >> a >> b)
    {
        if (a == 0) cout << getans(b) << endl;
        else cout << getans(b) - getans(a - 1) << endl;
    }
    return 0;
}

```


J **Watashi's BG**
原来BG是[请客的意思](http://zhidao.baidu.com/question/40254871)啊。物品数为30，容量为10000000的背包。
原来...搜索就可以过。两个减枝，一是要排序，二是如果后面那些都取还没有当前答案大，那就不用搜索了。

```cpp 

#include 
#include 
#include 
#include 
using namespace std;
int n, m;
int cost[35];
int sum[35];
int ans;
void search(int p, int money)
{
    //cout << p << " " << money << endl;
    if (ans == m) return;
    if (money > ans) ans = money;
    if (p == n) return;
    if (sum[p] + money <= ans) return;
    search(p+1, money);
    if (money + cost[p] <= m) search(p+1, money + cost[p]);
}
int main()
{
    while (cin >> n >> m)
    {
        for (int i = 0; i < n; i++) cin >> cost[i];
        sort(cost, cost + n, greater());
        memset(sum, 0, sizeof(sum));
        for (int i = n - 1; i >= 0; i--)
        {
            sum[i] = sum[i+1] + cost[i];
        }
        ans = 0;
        search(0, 0);
        cout << ans << endl;
    }
    return 0;
} 

```

另外一个想法，把物品分成两份，各15个，于是两侧各2^15种情况，对于每种情况在另外那边二分找最适合的，需要先排序。曾经把这个二分写错。

```cpp 

#include 
#include 
#include 
#include 
using namespace std;
const int MAXN = 55;
int a[32768], b[32768];
int cost[MAXN];
int calculate(int *ar, int left, int right)
{
    int end = 2 << (right-left) ;
    for (int i = 1; i < end; i++)
    {
        int count = 0;
        ar[i] = 0;
        for (int j = 1; j <= i; )
        {
            if (i & j) ar[i] += cost[left + count];
            j = j << 1;
            ++count;
        }
    }
    return end;
}

int search(int *ar, int l, int r, int m)
{
    //cout << l << " " << r << " " << m << endl;
    int left = l;
    int right = r;
    while (left < right)
    {
        int mid = (left + right) / 2;
        if (ar[mid] <= m && ar[mid+1] > m) return ar[mid];
        if (ar[mid] <= m)
        {
            left = mid + 1;
        }
        else
        {
            right = mid - 1;
        }
    }
    return ar[left];
}
int main()
{
    int n, m;
    while (cin >> n >> m)
    {
        for (int i = 1; i <= n; i++)
        {
            scanf("%d", &cost;[i]);
        }
        memset(a, 127, sizeof(a));
        memset(b, 127, sizeof(b));
        a[0] = b[0] = 0;
        if (n <= 15)
        {
            int end = calculate(a, 1, n);
            sort(a + 1, a + end);
            cout << search(a, 0, end - 1, m) << endl;
        }
        else
        {
            int aend = calculate(a, 1, 15);
            int bend = calculate(b, 16, n);
            sort(b + 1, b + bend);
            int ans = 0;
            for (int i = 0; i < aend; i++)
            {
                if (a[i] > m) continue;
                ans = max(ans, search(b, 0, bend -1, m - a[i]) + a[i]);
            }
            cout << ans << endl;
        }
    }
    return 0;
}

```

也可以两边都排序，然后扫一遍就行，这种会更好写。

K **Watermelon Full of Water**
买西瓜的时候一定选西瓜延续到当天并且花费最少的策略。（西瓜放这么多天不会坏吗...）
贪心、堆。用一个结构体wm存延续到哪一天last，和总花费cost，根据cost构造最小堆。堆初始化为0 0，如果延续不到“今天”就pop，然后根据堆顶元素创建新的wm，再push进去就好了。xenocide 写的代码好短。。好强大。

```cpp 

#include 
#include 
#include 
using namespace std;
const int MAXN = 50010;
struct wm
{
    int last;
    long long cost;
};

bool operator < (const wm &a;, const wm &b;)
{
    return a.cost > b.cost;
}

int main()
{
    int n;
    int last[MAXN]; // last[i] 表示第 i 天必须买瓜（从0开始）
    long long price[MAXN];
    priority_queue q;
    while (cin >> n)
    {
        for (int i = 0; i < n; i++) cin >> price[i];
        for (int i = 0; i < n; i++) scanf("%d", &last;[i]);
        while (!q.empty()) q.pop();
        wm temp;
        temp.cost = temp.last = 0;
        q.push(temp);
        for (int i = 0; i < n; i++)
        {
            while (q.top().last < i) q.pop();
            temp = q.top();
            temp.cost += price[i];
            temp.last = i + last[i];
            q.push(temp);
        }
        while (q.top().last < n) q.pop();
        cout << q.top().cost << endl;
    }
    return 0;
}

```


To do:
最后一题的线段树解法是什么意思
F题应该可以做，估计会很麻烦
C题xw给我讲了比较神奇的思路，应该也可做
