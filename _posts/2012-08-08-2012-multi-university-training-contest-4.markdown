---
author: admin
comments: true
date: 2012-08-08 05:41:54+00:00
layout: post
slug: 2012-multi-university-training-contest-4
title: 2012 Multi-University Training Contest 4
wordpress_id: 385
categories:
- Programming
---

官方题解：[http://page.renren.com/601081183/note/864084778
](http://page.renren.com/601081183/note/864084778)1001 **Image Recognition**
从01矩阵中找四条边都是1的正方形。
按照官方题解做的。
可以预处理出每一点上下左右四个方向上全部是1的长度，用l, r, u, d表示。接下来的想法是对于每条对角线（左上到右下），判断各点(i,  j)到能到达的最远点(i + min(r[i][j], d[i][j], j + min(r[i][j], d[i][j])，共min(r[i][j], d[i][j]个点里，哪些点往左上可以延伸到原来的(i, j)点，也就是(x, y)的坐标减去min(l[x][y], u[x][y])。这样是三次方的算法，会超时的。
在扫描对角线的时候记录各点能往左上延伸到哪里，相当于记录下坐标。若点(i, j)为1，定义一个区间为从点(i, j)开始到最远点(i + min(r[i][j], d[i][j], j + min(r[i][j], d[i][j])。当扫描到区间始点时，减去左上延伸到始点(i, j)以外的点的个数，扫描到区间终点时，加上左上延伸到始点以外的点的个数，这样就能算出区间内符合条件的点的个数。用线段树来维护每个点往左上能延伸到哪里，线段树的每个区间存区间内点的个数即可。复杂度O(n^2*logn）。写得好累啊。。

```cpp 

#include 
#include 
#include 
#include 
using namespace std;
const int MAXN = 1010;
int map[MAXN][MAXN];
int u[MAXN][MAXN], d[MAXN][MAXN], l[MAXN][MAXN], r[MAXN][MAXN];
int a[MAXN];
int visit[MAXN][MAXN];
struct node
{
    int l, r, count;
}tree[MAXN * 4];
void build(int num, int l, int r)
{
    tree[num].l = l;
    tree[num].r = r;
    tree[num].count = 0;
    if (l != r)
    {
        int mid = (l + r) / 2;
        build(num * 2, l, mid);
        build(num * 2 + 1, mid + 1, r);
    }
}
void insert(int num, int pos, int value)
{
    tree[num].count += value;
    if (tree[num].l == tree[num].r) return;
    int mid = (tree[num].l + tree[num].r) / 2;
    if (pos <= mid) insert(num * 2, pos, value);
    else insert(num * 2 + 1, pos, value);
}
int query(int num, int l, int r)
{
    if (tree[num].l == l && tree[num].r == r) return tree[num].count;
    int mid = (tree[num].l + tree[num].r) / 2;
    if (r <= mid) return query(num * 2, l, r);
    if (l > mid) return query(num * 2 + 1, l, r);
    return query(num * 2, l, mid) + query(num * 2 + 1, mid +1, r);
}
int work(int xx, int yy, int count)
{
    int ans = 0;
    build(1, 1, count);
    int x = xx, y = yy;
    //memset(visit, 0, sizeof(visit)); 会超时
    for (int i = 1; i <= count; i++) visit[i][0] = 0;
    for (int i = 1; i <= count; i++)
    {
        if (map[x][y] == 1)
        {
            a[i] = i - min(u[x][y], l[x][y]) + 1;
            if (i > 1) ans -= query(1, 1, i - 1);
            insert(1, a[i], 1);
            int temp = i + min(d[x][y], r[x][y]) - 1;
            visit[temp][++visit[temp][0]] = i;
        }
        if (visit[i][0]) for (int j = 1; j <= visit[i][0]; j++)
        {
            ans += query(1, 1, visit[i][j]);
        }
        ++x;
        ++y;
    }
    return ans;
}
int main()
{
    int t, casenum = 0;
    int n;
    cin >> t;
    while(t--)
    {
        scanf("%d", &n;);
        for (int i = 1; i <= n; i++)
            for (int j = 1; j <= n; j++)
            {
                scanf("%d", &map;[i][j]);
                if (map[i][j] == 1)
                {
                    u[i][j] = u[i-1][j] + 1;
                    l[i][j] = l[i][j-1] + 1;
                }
                else
                {
                    u[i][j] = 0;
                    l[i][j] = 0;
                }
            }
        memset(d, 0, sizeof(d));
        memset(r, 0, sizeof(r));
        for (int i = n; i >= 1; i--)
            for (int j = n; j >= 1; j--)
            {
                if (map[i][j] == 1)
                {
                    d[i][j] = d[i+1][j] + 1;
                    r[i][j] = r[i][j+1] + 1;
                }
                else
                {
                    d[i][j] = 0;
                    r[i][j] = 0;
                }
            }
        int ans = 0;
        for (int i = 1; i <= n; i++)
        {
            ans += work(1, i, n - i + 1);
        }
        for (int i = 2; i <= n; i++) ans += work(i, 1, n - i + 1);
        printf("Case %d: %d\n", ++casenum, ans);
    }
    return 0;
} 

```


1004 **Trouble**
给出五组数，每组各取一个，问能否使和为一。
分成两组、两组、一组。前两组求所有情况，存在sum1里，中间两组存在sum2里，排序sum1、sum2，然后对于最后一组的每个数，找sum1、sum2里有没有两个数的和为这个数的相反数。复杂度O(n^3)。

```cpp 

#include 
#include 
#include 
#include 
using namespace std;
const int MAXN = 205;
long long sum1[MAXN*MAXN], sum2[MAXN*MAXN];
long long num[6][MAXN];
int main()
{
    int t;
    cin >> t;
    while (t--)
    {
        int n;
        cin >> n;
        for (int i = 0; i < 5; i++)
        {
            for (int j = 0; j < n; j++) scanf("%I64d", &num;[i][j]);
        }
        int count = 0;
        for (int i = 0; i < n; i++)
        {
            for (int j = 0; j < n; j++)
            {
                sum1[count] = num[0][i] + num[1][j];
                sum2[count++] = num[2][i] + num[3][j];
            }
        }
        sort(sum1, sum1 + count);
        sort(sum2, sum2 + count, greater());
        bool found = false;
        for (int i = 0; i < n; i++)
        {
            long long goal = -num[4][i];
            int p1 = 0;
            int p2 = 0;
            while (p1 < count && p2 < count)
            {
                if (sum1[p1] + sum2[p2] == goal)
                {
                    found = true;
                    break;
                }
                if (sum1[p1] + sum2[p2] < goal) p1++;
                else p2++;
            }
            if (found) break;
        }
        if (found) puts("Yes");
        else puts("No");
    }
    return 0;
} 

```


1009 **Query**
给出两个字符串，随时可能修改某个字符，找出从任意字符开始，最长字符相同的长度。
这题如果想到怎么建线段树就很好做了，可惜当时想不到。记录区间里第一个不同的字符的位置。找所求位置到最后第一个不同字符的位置即可。

```cpp 

#include 
#include 
#include 
#include 
#include 
using namespace std;
const int MAXL = 1000010;

char s1[MAXL], s2[MAXL];
struct node
{
    int l, r, pos;
}tree[MAXL * 4];
int length;

inline int getleft(const int &a;, const int &b;)
{
    if (a == -1) return b;
    if (b == -1) return a;
    return min(a, b);
}

void build(int num, int l, int r)
{
    tree[num].l = l;
    tree[num].r = r;
    if (l < r)
    {
        int mid = (l + r) / 2;
        build(num * 2, l, mid);
        build(num * 2 + 1, mid + 1, r);
        tree[num].pos = getleft(tree[num*2].pos, tree[num*2 + 1].pos);
    }
    else
    {
        if (s1[l] == s2[l]) tree[num].pos = -1;
        else tree[num].pos = l;
    }
}

int query(int num, int l, int r)
{
    if (l == tree[num].l && r == tree[num].r) return tree[num].pos;
    int mid = (tree[num].l + tree[num].r) / 2;
    if (r <= mid) return query(num * 2, l, r);
    if (l > mid) return query(num * 2 + 1, l , r);
    return getleft(query(num * 2, l, mid), query(num * 2 + 1, mid + 1, r));
}

void modify(int num, int pos)
{
    if (tree[num].l == tree[num].r)
    {
        if (s1[pos] == s2[pos]) tree[num].pos = -1;
        else tree[num].pos = tree[num].l;
    }
    else
    {
        int mid = (tree[num].l + tree[num].r) / 2;
        if (pos <= mid) modify(num * 2, pos);
        if (pos > mid) modify(num * 2 + 1, pos);
        tree[num].pos = getleft(tree[num*2].pos, tree[num*2 + 1].pos);
    }
}

int main()
{
    int t, caseno = 0, q, action, a, pos;
    char ch;
    cin >> t;
    char useless[10];
    while (t--)
    {
        printf("Case %d:\n", ++caseno);
        gets(useless);
        scanf("%s", s1);
        scanf("%s", s2);
        length = min(strlen(s1), strlen(s2));
        //cout << length << endl;
        build(1, 0, length - 1);
        scanf("%d", &q;);
        while (q--)
        {
            scanf("%d", &action;);
            if (action == 1)
            {
                scanf("%d %d %c", &a;, &pos;, &ch;);
                if (pos >= length) continue;
                if (a == 1)
                {
                    if (s1[pos] == ch) continue;
                    if (s1[pos] != s2[pos] && ch != s2[pos])
                    {
                        s1[pos] = ch;
                        continue;
                    }
                    else s1[pos] = ch;
                }
                if (a == 2)
                {
                    if (s2[pos] == ch) continue;
                    if (s1[pos] != s2[pos] && ch != s1[pos])
                    {
                        s2[pos] = ch;
                        continue;
                    }
                    else s2[pos] = ch;
                }
                modify(1, pos);
            }
            else
            {
                scanf("%d", &pos;);
                int result = query(1, pos, length - 1);
                if (result != -1) printf("%d\n", result - pos);
                else printf("%d\n", length - pos);
            }
        }
    }
    return 0;
} 

```

