---
author: admin
comments: true
date: 2012-08-15 15:43:08+00:00
layout: post
slug: codeforces-round-133-div-2
title: 'Codeforces Round #133 (Div. 2)'
wordpress_id: 391
categories:
- Programming
tags:
- Codeforces
---

这次比赛很爽啊，四题，room leader。Rating 终于过 1500 了。Div. 2 专场的题目貌似要简单一些。
**A. Tiling with Hexagons**
分成几个平行四边形，再减去相邻平行四边形重合的面积。\(a*b+b*c+c*a-(a+b+c)+1\)

**B. Forming Teams**
这道题有个很强烈的限制条件，每个学生最多有两个敌人。于是分为三种情况，环、链和孤立的点，如果环上的结点数为奇数，这个环上一定有个点要被取下。有偶数个节点的链也可以平分为两份，有奇数个节点的链分完之后只能是某一份多一个，奇数个有奇数个节点的链的结果还是某一份多一个，再考虑孤立的点，所以其实只要考虑环，然后剩下的节点数如果是奇数就去得掉一个。

```cpp 

#include 
#include 
using namespace std;
int map[105][105];
void addedge(int a, int b)
{
    map[a][++map[a][0]] = b;
}
int ans;
int visited[105];
void search(int node, int depth)
{
    if (visited[node])
    {
        if (depth - visited[node] > 1)
        {
            if ((depth - visited[node]) % 2) ++ans;
            return;
        }
        else return;
    }
    visited[node] = depth;
    for (int i = 1; i <= map[node][0]; i++)
    {
        search(map[node][i], depth + 1);
    }
}
int main()
{
    int n, m;
    cin >> n >> m;
    int a, b;
    for (int i = 0; i < m; i++)
    {
        cin >> a >> b;
        addedge(a, b);
        addedge(b, a);
    }
    for (int i = 1; i <= n; i++)
    {
        if (!visited[i]) search(i, 1);
    }
    if ((n - ans) % 2) ++ans;
    cout << ans << endl;
    return 0;
}

```


**C. Hiring Staff**
这道题也有非常强的限制条件，\(m\leq n\) 且 \(n \neq 1\)。
写写算算就出来答案了。
第一天需要 k 个人，第 n 天需要一个，第 n+1 天需要 k-1 个，若 \(m \leq n-1\)，到此结束。若 \(m=n\)，第 2n 天还需要一个，到此结束。其实如果 m > n，应该是第 i*n 天一个，第 i*n+1 天 k-1 个吧，\(k \geq2\)，直到 n+m+1 天为止。

```cpp 

#include 
#include 
using namespace std;
int a[1000000];
int count = 0;
int n, m, k;
void work()
{
    if (k == 1)
    {
        int i = 1;
        while (i < n + m + 1)
        {
            a[count++] = i;
            i += n - 1;
        }
    }
    else
    {
        for (int i = 0; i < k; i++) a[count++] = 1;
        a[count++] = n;
        for (int i = 0; i < k - 1; i++) a[count++] = n + 1;
        if (m <= n - 1) return;
        if (m == n)
        {
            a[count++] = n * 2;
            return;
        }
        if (m > n)
        {
            int i = 2 * n;
            while (true)
            {
                if (n + m + 1 >= i) break;
                a[count++] = i;
                if (n + m + 1 >= i) break;
                ++i;
                a[count++] = i;
                i += n - 1;
            }
        }
    }
}
int main()
{
    cin >> n >> m >> k;
    work();
    cout << count << endl;
    cout << a[0];
    for (int i = 1; i < count; i++) cout << " " << a[i];
    cout << endl;
    return 0;
}

```


**D. Spider's Web**
这题最难的地方在于读题。对于每个 sector 处理一下就可以了。
每个 sector 可能有 \(10^5\) 个 bridge，bridge 的总数不超过 \(10^5\)，开数组存不下，只好用 vector 啦。

```cpp 

#include 
#include 
#include 
#include 
#include 
using namespace std;
const int MAXN = 1010;
int ans = 0;
vector num[MAXN];
void work(int cur, int prev, int next)
{
    int pcur = 0, pp = 0, pn = 0;
    while (num[prev][pp] < num[cur][pcur] && pp < num[prev].size()) ++pp;
    while (num[next][pn] < num[cur][pcur] && pn < num[next].size()) ++pn;
    ++pcur;
    while (pcur < num[cur].size())
    {
        int oldpp = pp, oldpn = pn;
        while (num[prev][pp] < num[cur][pcur] && pp < num[prev].size()) ++pp;
        while (num[next][pn] < num[cur][pcur] && pn < num[next].size()) ++pn;
        if (pp - oldpp != pn - oldpn) ++ans;
        ++pcur;
    }
}
int main()
{
    int n, k, temp;
    cin >> n;
    for (int i = 1; i <= n; i++)
    {
        cin >> k;
        for (int j = 0; j < k; j++)
        {
            cin >> temp;
            num[i].push_back(temp);
        }
        sort(num[i].begin(), num[i].end());
    }
    for (int i = 2; i < n; i++)
    {
        work(i, i - 1, i + 1);
    }
    work(1, n, 2);
    work(n, n - 1, 1);
    cout << ans << endl;
    return 0;
}

```

