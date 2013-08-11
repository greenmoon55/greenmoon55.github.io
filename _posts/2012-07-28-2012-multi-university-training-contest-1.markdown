---
author: admin
comments: true
date: 2012-07-28 11:59:42+00:00
layout: post
slug: 2012-multi-university-training-contest-1
title: 2012 Multi-University Training Contest 1
wordpress_id: 377
categories:
- Programming
tags:
- DP
- 最短路
- 线段树
---

官方题解：[2012 Multi-University Training Contest 1 Solution Report](http://page.renren.com/601081183/note/861865911)

**1001 Clairewd’s message**
[HDU4300](http://acm.hdu.edu.cn/showproblem.php?pid=4300)
给出一个密码转换表和一个字符串（消息），这个消息由密文和原文组成，原文部分可能不完全，求最短可能的原文。
官方题解说要用到KMP，比赛的时候看到有那么多人过，根本没考虑复杂度，我是用给出的原文到密文的转换表求出密文的原文的转换表，然后随便搞搞就过了。

**1002 Divide Chocolate**
[HDU4301](http://acm.hdu.edu.cn/showproblem.php?pid=4301)
把2*n的巧克力分为k块，问有多少种方法？
f[i][j][0]表示前i行分成了j块，且第i行两格巧克力未被分开。
f[i][j][1]表示前i行分成了j块，且第i行两格巧克力属于不同的两块。
详见官方题解

```cpp 

#include 
#include 
#include 
using namespace std;
const int MOD = 100000007;
int f[1010][2020][2];
int main()
{
    int t, n, k;
    cin >> t;
    while (t--)
    {
        cin >> n >> k;
        memset(f, 0, sizeof(f));
        f[1][1][0] = f[1][2][1] = 1;
        for (int i = 1; i < n; i++)
        {
            for (int j = 1; j <= k; j++)
            {
                f[i+1][j][0] = (f[i+1][j][0] + f[i][j][0] + f[i][j][1] * 2) % MOD;
                f[i+1][j+1][0] = (f[i+1][j+1][0] + f[i][j][0] + f[i][j][1]) % MOD;
                f[i+1][j][1] = (f[i+1][j][1] + f[i][j][1]) % MOD;
                f[i+1][j+1][1] = (f[i+1][j+1][1] + f[i][j][0] * 2 + f[i][j][1] * 2) % MOD;
                f[i+1][j+2][1] = (f[i+1][j+2][1] + f[i][j][0] + f[i][j][1]) % MOD;
            }
        }
        cout << (f[n][k][0] + f[n][k][1]) % MOD << endl;
    }
    return 0;
}

```


**1003 Holedox Eating**
[HDU4302](http://acm.hdu.edu.cn/showproblem.php?pid=4302)
每个时刻有两种动作，放食物和吃食物，吃的时候选择离当前位置最近的食物。
线段树，区间里记录最左面和最右面的食物位置，曾经把MAX设得太大导致RUNTIME ERROR(ACCESS_VIOLATION)，花了好久才明白是哪里错了。。

```cpp 

#include 
#include 
#include 
#include 
using namespace std;
const int N = 100010;
struct Node
{
    int l, r;
    int leftmost, rightmost;
    int count;
}tree[N * 4];

const int MAX = 1083647;
const int MIN = -MAX;
const int LEFT_TO_RIGHT = 0;
const int RIGHT_TO_LEFT = 1;

void build(int num, int l, int r)
{
    tree[num].l = l;
    tree[num].r = r;
    tree[num].count = 0;
    tree[num].leftmost = MAX;
    tree[num].rightmost = MIN;
    int mid = (l + r) / 2;
    if (l < r)
    {
        build(num * 2, l, mid);
        build(num * 2 + 1, mid + 1, r);
    }
}

void insert(int num, int place)
{
    if (tree[num].leftmost > place) tree[num].leftmost = place;
    if (tree[num].rightmost < place) tree[num].rightmost = place;
    ++tree[num].count;
    if (tree[num].l == tree[num].r) return;
    int mid = (tree[num].l + tree[num].r) / 2;
    if (place <= mid) insert(num * 2, place);
    else insert(num * 2 + 1, place);
}

void remove(int num, int place)
{
    --tree[num].count;
    if (tree[num].l == tree[num].r)
    {
	// 这个位置没有蛋糕了，要恢复MAX和MIN
        if (!tree[num].count)
        {
            tree[num].leftmost = MAX;
            tree[num].rightmost = MIN;
        }
    }
    else
    {
        int mid = (tree[num].l + tree[num].r) / 2;
        if (place <= mid) remove(num * 2, place);
        else remove(num * 2 + 1, place);
        tree[num].leftmost = min(tree[num * 2].leftmost, tree[num * 2 + 1].leftmost);
        tree[num].rightmost = max(tree[num * 2].rightmost, tree[num * 2 + 1].rightmost);
    }
}

int getleftmost(int num, int l, int r)
{
    //printf("%d %d %d %d %d\n", num, tree[num].l, tree[num].r, l, r);
    if (tree[num].l == l && tree[num].r == r) return tree[num].leftmost;
    int mid = (tree[num].l + tree[num].r) / 2;
    if (r <= mid) return getleftmost(num * 2, l, r);
    if (l > mid) return getleftmost(num * 2 + 1, l, r);
    return min(getleftmost(num * 2, l, mid), getleftmost(num * 2 + 1, mid  + 1, r));
}

int getrightmost(int num, int l, int r)
{
    //printf("%d %d %d %d %d\n", num, tree[num].l, tree[num].r, l, r);
    if (tree[num].l == l && tree[num].r == r) return tree[num].rightmost;
    int mid = (tree[num].l + tree[num].r) / 2;
    if (r <= mid) return getrightmost(num * 2, l, r);
    if (l > mid) return getrightmost(num * 2 + 1, l, r);
    return max(getrightmost(num * 2, l, mid), getrightmost(num * 2 + 1, mid + 1, r));
}

int main()
{
    int t, l, n;
    cin >> t;
    for (int tcase = 1; tcase <= t; tcase++)
    {
        scanf("%d%d", &l;, &n;);
        build(1, 0, l);
        int temp;
        int pos = 0;
        long long ans = 0;
        int direction;
        for (int i = 0; i < n; i++)
        {
            scanf("%d", &temp;);
            if (temp == 0) // 放蛋糕
            {
                int x;
                scanf("%d", &x;);
                insert(1, x);
            }
            else // 吃蛋糕
            {
                int rightmost = getrightmost(1, 0, pos);
                int leftmost = getleftmost(1, pos, l);
                if (rightmost == MIN && leftmost == MAX) continue;
                int disleft = pos - rightmost; // 向左走的距离
                int disright = leftmost - pos; // 向右走的距离
                if (disleft < disright || (disleft == disright && direction == RIGHT_TO_LEFT))
                {
		    // 注意如果蛋糕就在当前位置就不需要更新方向，下同
                    if (disleft != 0) direction = RIGHT_TO_LEFT;
                    remove(1, rightmost);
                    ans += disleft;
                    pos = rightmost;
                }
                else
                {
                    if (disright != 0) direction = LEFT_TO_RIGHT;
                    remove(1, leftmost);
                    ans += disright;
                    pos = leftmost;
                }
            }
        }
        printf("Case %d: ", tcase);
        cout << ans << endl;
    }
    return 0;
}

```

**1009 Saving Princess claire_**
[HDU4308](http://acm.hdu.edu.cn/showproblem.php?pid=4308)
把所有的P看成一个点（这里设为0），然后Dijkstra求最短路即可。

```cpp 

#include 
#include 
#include 
using namespace std;
const int MAXN = 5010;
const int MAXM = 500010;
const int INF = 0x7f7f7f7f;
char map[MAXN][MAXN];
int head[MAXN];
int edgecount;
int r, c;
struct edge
{
    int u, v, w;
    int next;
}e[MAXM];

inline int getpos(int i, int j)
{
    if (map[i][j] == 'P') return 0;
    return i * c + j + 1;
}

// 添加一条从u到v的边
void addedge(int u, int v, int w)
{
    e[edgecount].u = u;
    e[edgecount].v = v;
    e[edgecount].w = w;
    e[edgecount].next = head[u];
    head[u] = edgecount;
    ++edgecount;
}

int main()
{
    int cost;
    int start, end;
    int dist[MAXN];
    bool used[MAXN];
    int maxn;
    while (cin >> r >> c >> cost)
    {
        getchar();
        for (int i = 0; i < r; i++) gets(map[i]);

        edgecount = 0;
        memset(head, -1, sizeof(head));
        maxn = r * c;

        for (int i = 0; i < r; i++)
        {
            for (int  j = 0; j < c; j++)
            {
                if (map[i][j] == '#') continue;
                int w;
                if (map[i][j] == '*') w = cost;
                else
                {
                    w = 0;
                    if (map[i][j] == 'Y') start = getpos(i, j);
                    else if (map[i][j] == 'C') end = getpos(i, j);
                }
                if (i > 0 && map[i-1][j] != '#') addedge(getpos(i-1, j), getpos(i, j), w);
                if (j > 0 && map[i][j-1] != '#') addedge(getpos(i, j-1), getpos(i, j), w);
                if (i+1 < r && map[i+1][j] != '#') addedge(getpos(i+1, j), getpos(i,j), w);
                if (j+1 < c && map[i][j+1] != '#') addedge(getpos(i, j+1), getpos(i,j), w);
            }
        }
        memset(dist, 127, sizeof(dist));
        dist[start] = 0;
        int nodenow;
        int mindis;
        int ans = 0;
        memset(used, 0, sizeof(used));
        for (int i = 0; i <= maxn; i++)
        {
            mindis = INF;
            for (int j = 0; j <= maxn; j++) if (!used[j] && dist[j] < mindis)
            {
                mindis = dist[j];
                nodenow = j;
            }
            if (mindis == INF) break;
            ans += mindis;
            used[nodenow] = true;
            if (nodenow == end) break;
            int edgenumber = head[nodenow];
            while (edgenumber != -1)
            {
                int newdis = mindis + e[edgenumber].w;
                int newnode = e[edgenumber].v;
                if (!used[newnode] && newdis < dist[newnode]) dist[newnode] = newdis;
                edgenumber = e[edgenumber].next;
            }
        }
        if (used[end]) cout << dist[end] << endl;
        else puts("Damn teoy!");
    }
    return 0;
}

```


比赛的时候只做了1001，然后就没什么想法了。。那时候刚过一小时左右。然后去洗澡，还有点感冒了。当天早上还断网了，刚好用完一年的网费。1003想到是线段树不过不会写。
