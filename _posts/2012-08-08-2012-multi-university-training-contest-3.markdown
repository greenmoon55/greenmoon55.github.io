---
author: admin
comments: true
date: 2012-08-08 04:09:17+00:00
layout: post
slug: 2012-multi-university-training-contest-3
title: 2012 Multi-University Training Contest 3
wordpress_id: 384
categories:
- Programming
---

官方题解：[http://blog.renren.com/blog/601081183/863771603](http://blog.renren.com/blog/601081183/863771603)

1001 **Arcane Numbers 1**
问任意一个A进制有限小数，能否用B进制有限小数表示。
A进制小数可以转换为X*A^(-n)，n为小数部分位数，这个数除以任意次B^(-i)，i从1递增，直到得到一个整数，也就是说，如果A的质因子在B中都包含即可。注意A的某个质因子可能大于sqrt(A)，这道题就因为这个WA到最后= =

```cpp 

#include 
#include 
#include 
#include 
#include 
using namespace std;
const int MAXN = 1000010;
int prime[MAXN];
bool notprime[MAXN];
int primecount = 0;
void getprime()
{
    memset(notprime, 0, sizeof(notprime));
    for (int i = 2; i < MAXN; i++)
    {
        if (!notprime[i])
        {
            prime[primecount++] = i;
            for (int j = 2; i * j < MAXN; j++)
            {
                notprime[i * j] = true;
            }
        }
    }
}
int main()
{
    int t;
    long long a, b;
    cin >> t;
    getprime();
    for (int tt = 1; tt <= t; tt++)
    {
        printf("Case #%d: ", tt);
        cin >> a >> b;
        if (a < 0 || b < 0)
        {
            puts("NO");
            continue;
        }
        if (a == b && a != 0)
        {
            puts("YES");
            continue;
        }
        if (a <= 1 || b <= 1)
        {
            puts("NO");
            continue;
        }
        int end = sqrt(a);
        bool ok = true;
        for (int i = 0; i < primecount; i++)
        {
            if (prime[i] > end) break;
            if (a % prime[i] == 0)
            {
                if (b % prime[i] != 0)
                {
                    ok = false;
                    break;
                }
                while (a % prime[i] == 0)
                {
                    a /= prime[i];
                }
            }
        }
        if (a > 1)
        {
            if (b % a != 0) ok = false;
        }
        if (ok) puts("YES");
        else puts("NO");
    }
    return 0;
}

```


1004 **Magic Number**
求字符串间的[编辑距离](http://zh.wikipedia.org/zh-cn/%E7%B7%A8%E8%BC%AF%E8%B7%9D%E9%9B%A2)
dp[i][j]可以表示为把第一个字符串前i个字符转换为第二个字符串前j个字符需要的操作数。
dp[i][j] = min(dp[i-1][j]+1（删除原串第i个字符）, dp[i][j-1]+1（插入新串第j个字符）, dp[i-1][j-1]+(oldstr[i]==newstr[j])?0:1（修改）)

```cpp 

#include 
#include 
#include 
#include 
using namespace std;
char magic[1510][15];
char query[15];
inline int min(const int &a;, const int &b;, const int &c;)
{
    if (a < b) return a < c ? a : c;
    else return b < c ? b : c;
}

int main()
{
    int t, n, m;
    int f[15][15];
    int limit;
    scanf("%d", &t;);
    for (int tt = 1; tt <= t; tt++)
    {
        scanf("%d%d", &n;, &m;);
        printf("Case #%d:\n", tt);
        getchar();
        for (int i = 0; i < n; i++) gets(magic[i]);
        for (int ii = 0; ii < m; ii++)
        {
            scanf("%s%d", query, &limit;);
            int ans = 0;
            for (int jj = 0; jj < n; jj++)
            {
                int x = strlen(query);
                int y = strlen(magic[jj]);
                f[0][0] = 0;
                for (int i = 1; i <= x; i++) f[i][0] = i;
                for (int j = 1; j <= y; j++) f[0][j] = j;
                for (int i = 1; i <= x; i++)
                {
                    for (int j = 1; j <= y; j++)
                    {
                        f[i][j] = min(f[i-1][j]+1, f[i][j-1]+1, f[i-1][j-1] + ((query[i-1] == magic[jj][j-1])? 0:1));
                    }
                }
                if (f[x][y] <= limit) ++ans;
            }
            printf("%d\n", ans);
        }
    }
    return 0;
} 

```


1005 **Triangle LOVE**
给出一个[竞赛图](http://en.wikipedia.org/wiki/Tournament_(graph_theory))（由无向完全图给每条边加方向构成），问有没有长度为3的环。
方法一，从任意一点出发遍历整个图，搜的时候记录深度，找环。[http://euyuil.com/2687/codeforces-117c-cycle/](http://euyuil.com/2687/codeforces-117c-cycle/)
官方题解里的增量算法有点晕。。
竞赛图上如果有环，则一定存在长度为3的环。因为若有长度为n的环，一定有长度为n-1的环，画一下就懂了。所以只要DFS判断有没有环即可。
最简单的想法：若存在两个点出度相同则存在长度为3的环。先找出两个点A和B，若A到B有边，此时A出度为1，B出度为0。对于其他任意一点C，有以下四种情况：AB出度都加一，AB出度不变、A出度加一，B出度不变、A出度不变，B出度加一。要想使AB出度相同，必须有B的出度加一、C的出度不变的情况，B到C、C到A有边才可以。这样ABC就形成了一个环。
神奇的图论啊！

1006 **Flowers**
花在一段时间内开放，问某一时刻最多开多少花。
很明显，离散化区间更新的线段树，没想到这道题过的人这么多。。大家都好强啊。
把每个区间离散为三个点，如[1,4]分为[1,1],[2,3]和[4,4]即可。

```cpp 

#include 
#include 
#include 
#include 
using namespace std;
const int MAXN = 100010;
struct flower
{
    int s, t;
}f[MAXN];
struct Node
{
    int l, r;
    int sum, inc;
}tree[MAXN * 4 * 4];
int mycount;
int a[MAXN * 2];

void build(int num, int l, int r)
{
    tree[num].l = l;
    tree[num].r = r;
    int mid = (l + r) / 2;
    if (l < r)
    {
        build(num * 2, l, mid);
        build(num * 2 + 1, mid + 1, r);
    }
}

int convert(int x)
{
    int left = 0;
    int right = mycount - 1;
    int mid;
    while (left < right)
    {
        mid = (left + right) / 2;
        if (x > a[mid]) left = mid + 1;
        else right = mid;
    }
    return left * 2;
}

void getsegment(int x, int &s;, int &t;)
{
    int left = 0;
    int right = mycount - 1;
    int mid;
    while (left <= right)
    {
        mid = (left + right) / 2;
        if (x == a[mid])
        {
            s = mid * 2;
            t = mid * 2;
            return;
        }
        if (x > a[mid] && x < a[mid + 1])
        {
            s = mid * 2 + 1;
            t = mid * 2 + 1;
            return;
        }
        if (x > a[mid])
        {
            left = mid + 1;
        }
        else
        {
            right = mid - 1;
        }
    }
}

void add(int num, int l, int r, int value)
{
    if (tree[num].l == l && tree[num].r == r)
    {
        tree[num].inc += value;
        return;
    }
    int mid = (tree[num].l + tree[num].r) / 2;
    if (l > mid) add(num * 2 + 1, l, r, value);
    else if (r <= mid) add(num * 2, l, r, value);
    else
    {
        add(num * 2, l , mid, value);
        add(num * 2 + 1, mid + 1, r, value);
    }
}

int query(int num, int l, int r)
{
    if (l == tree[num].l && r == tree[num].r)
    {
        return tree[num].sum + tree[num].inc;
    }
    int mid = (tree[num].l + tree[num].r) / 2;
    if (tree[num].inc)
    {
        add(num * 2, tree[num].l, mid, tree[num].inc);
        add(num * 2 + 1, mid + 1, tree[num].r, tree[num].inc);
        tree[num].sum += tree[num].inc;
        tree[num].inc = 0;
    }
    if (l > mid) return query(num * 2 + 1, l, r);
    else if (r <= mid) return query(num * 2, l , r);
    else
    {
        return query(num * 2, l, mid) + query(num * 2 + 1, mid + 1, r);
    }
}

int main()
{
    int t;
    int n, m;
    cin >> t;
    for (int tt = 1; tt <= t; tt++)
    {
        memset(tree, 0, sizeof(tree));
        printf("Case #%d:\n", tt);
        cin >> n >> m;
        int temp = 0;
        for (int i = 0; i < n; i++)
        {
            scanf("%d%d", &f;[i].s, &f;[i].t);
            a[temp++] = f[i].s;
            a[temp++] = f[i].t;
        }
        sort(a, a + temp);
        mycount = unique(a, a + temp) - a;
        build(1, 0, (mycount - 1) * 2);
        for (int i = 0; i < n; i++)
        {
            add(1, convert(f[i].s), convert(f[i].t), 1);
        }
        int pos;
        for (int i = 0; i < m; i++)
        {
            scanf("%d", &pos;);
            if (pos < a[0] || pos > a[mycount - 1])
            {
                printf("0\n");
                continue;
            }
            int s, t;
            getsegment(pos, s, t);
            printf("%d\n", query(1, s, t));
        }
    }
    return 0;
} 

```


1009 **Cut the cake**
对于颜色相间的**正方形**，用dp[i][j]表示右下角为(i,j)的最大矩形边长，实时更新答案，首先判断(i,j)，(i-1,j)，(i,j-1)这三个点，若颜色不合法则记为1。若dp[i][j-1]等于dp[i-1][j]，要判断左上角那个点的颜色是否符合。若dp[i][j-1]不等于dp[i-1][j]，dp[i][j] = min(dp[i][j-1], dp[i-1][j]) + 1。
对于颜色相同的矩形，其实就是一个找最大子矩形的问题，推荐王知昆的论文《浅谈用极大化思想解决最大子矩形问题》，用到里面第二种方法。
定义悬线为从矩形上边，上端点覆盖了一个障碍点或达到整个矩形上端的有效竖线（不覆盖任何障碍点），把悬线尽量左右移动，就可以形成一个矩形。考虑每个悬线（最多N*M个）最多能移动多少就能求出最大子矩形。需要left[i][j]，right[i][j]，height[i][j]三个数组，分别记录，往左、往右、往上能移动到哪里。从上往下扫，然后每行从左往右、从右往左各扫一遍，leftmost记录最左非障碍点位置，left[i][j] = max(left[i-1][j], leftmost)，右边同理。遇到障碍点就把left[i][j]置为1，right[i][j]置为m，height[i][j]置为0。O(N*M)

```cpp 

#include 
#include 
#include 
#include 
using namespace std;
const int MAXN = 1010;
char map[MAXN][MAXN];
int dp[MAXN][MAXN];
int height[MAXN][MAXN], l[MAXN][MAXN], r[MAXN][MAXN];
int work(char ch, const int &n;, const int &m;)
{
    memset(height, 0, sizeof(height));
    int ans = 0;
    int leftmost , rightmost;
    for (int j = 1; j <= m; j++)
    {
        l[0][j] = 1;
        r[0][j] = m;
    }
    for (int i = 1; i <= n; i++)
    {
        leftmost = 1;
        rightmost = m;
        for (int j = 1; j <= m; j++)
        {
            if (map[i][j] != ch)
            {
                leftmost = j + 1;
                height[i][j] = 0;
                l[i][j] = 1; //不影响下一行的min 和 max
                r[i][j] = m;
            }
            else
            {
                height[i][j] = height[i-1][j] + 1;
                l[i][j] = max(l[i-1][j], leftmost);
            }
        }
        for (int j = m; j >= 1; j--)
        {
            if (map[i][j] == ch)
            {
                r[i][j] = min(r[i-1][j], rightmost);
                ans = max(ans, (r[i][j] - l[i][j] + 1 + height[i][j]) * 2);
            }
            else
            {
                rightmost = j - 1;
            }
        }
    }
    return ans;
}
int main()
{
    char s[MAXN];
    int t, n, m;
    cin >> t;
    for (int tt = 1; tt <= t; tt++)
    {
        scanf("%d%d", &n;, &m;);
        gets(s);
        for (int i = 1; i <= n; i++) gets(map[i] + 1);
        int ans = 0;
        memset(dp, 0, sizeof(dp));
        for (int i = 1; i <= n; i++)
        {
            for (int j = 1; j <= m; j++)
            {
                if (i > 1 && j > 1)
                {
                    if (map[i][j] == map[i][j-1] || map[i][j] == map[i-1][j]) dp[i][j] = 1;
                    else
                    {
                        if (dp[i][j-1] != dp[i-1][j]) dp[i][j] = min(dp[i][j-1], dp[i-1][j]) + 1;
                        else
                        {
                            int count = dp[i][j-1];
                            if (map[i-count][j-count] == map[i][j]) dp[i][j]  = count + 1;
                            else dp[i][j] = count;
                        }
                    }
                }
                else dp[i][j] = 1;
                if (dp[i][j] > ans) ans = dp[i][j];
            }
        }
        ans *= 4;
        ans = max(ans, work('B', n, m));
        ans = max(ans, work('R', n, m));
        printf("Case #%d: %d\n", tt, ans);
    }
    return 0;
}

```


1010 **MAP**
我擦啊，这么简单的题意，说得这么恶心。用 map 和 set 写起来挺爽的，貌似数据都是按顺序的，用不到 map...
C++ 还有 istringstream 这么神奇的东西啊。貌似这题数据是\r\n，所以。。如果gets读换行符就会被坑了= =

```cpp 

#include 
#include 
#include 
#include 
#include 
#include 
#include 
using namespace std;
int main()
{
    int t, n;
    string url;
    map<string, int> querymap;
    set urlset[105];
    int c[105];
    cin >> t;
    for (int tt = t; tt <= t; tt++)
    {
        cin >> n;
        string name;
        string line;
        querymap.clear();
        memset(c, 0, sizeof(c));
        double ans = 0;
        for (int i = 0; i < n; i++)
        {
            cin >> name;
            querymap.insert(pair<string, int>(name, i));
            urlset[i].clear();
            getline(cin, line);
            istringstream iss(line);
            while (iss >> url)
            {
                //cout << url << endl;
                c[i]++;
                urlset[i].insert(url);
            }
        }
        for (int i = 0; i < n; i++)
        {
            cin >> name;
            int index = querymap[name];
            getline(cin, line);
            istringstream iss(line);
            int r = 0;
            int count = 0;
            double sum = 0;
            while (iss >> url)
            {
                ++r;
                if (urlset[index].count(url))
                {
                    ++count;
                    sum += count / (double)r;
                }
            }
            if (c[i]) ans += sum / c[i];
        }
        printf("Case #%d: %.6lf\n", tt, ans / n);
    }
    return 0;
} 

```

