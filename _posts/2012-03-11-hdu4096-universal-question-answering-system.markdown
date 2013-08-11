---
author: admin
comments: true
date: 2012-03-11 06:27:07+00:00
layout: post
slug: hdu4096-universal-question-answering-system
title: HDU4096 Universal Question Answering System
wordpress_id: 345
categories:
- Programming
tags:
- ACM
---

其实是2010年[上海赛区F题](http://acm.hdu.edu.cn/showproblem.php?pid=4096)，现场读入数据就写了很久...交上去之后是个诡异的错误，现在忘了是啥错误了...

连边判断连通性即可。这个题比较坑人...输入数据就比较恶心，当时还不会sscanf。名词和动词可能一样，所以需要两个map来存，还可能直接问are cat cat?要输出Y...

BFS和DFS时间差不多...
[http://acm.fudan.edu.cn](http://acm.fudan.edu.cn) 还有数据呢。


```cpp 

#include 
#include 
#include 
#include 
#include 
//#include 
using namespace std;

const int N = 205;

map<string, int> nmap, vmap;
int mapcount;

int getn(char* ch)
{
    if (!nmap.count(ch)) nmap[ch] = mapcount++;
    return nmap[ch];
}

int getv(char* ch)
{
    if (!vmap.count(ch)) vmap[ch] = mapcount++;
    return vmap[ch];
}

struct edge
{
    int v, next;
}e[N * N];
int head[N], edgenum;

void addedge(int a, int b)
{
    e[edgenum].v = b;
    e[edgenum].next = head[a];
    head[a] = edgenum++;
}

void workstatement(char *buf)
{
    char n1[20], n2[20];
    int a, b;
    if (sscanf(buf, "%s are %s", n1, n2) == 2)
    {
        a = getn(n1);
        b = getn(n2);
    }
    else if (sscanf(buf, "%s can %s", n1, n2) == 2)
    {
        a = getn(n1);
        b = getv(n2);
    }
    else if (sscanf(buf, "everything which can %s can %s", n1, n2) == 2)
    {
        a = getv(n1);
        b = getv(n2);
    }
    else if (sscanf(buf, "everything which can %s are %s", n1, n2) == 2)
    {
        a = getv(n1);
        b = getn(n2);
    }
    //else assert("workstatement error");
    addedge(a, b);
}

bool vis[N];
/*
bool dfs(int a, int b)
{
    vis[a] = true;
    if (a == b) return true;
    for (int i = head[a]; i != -1; i = e[i].next)
    {
        if (!vis[e[i].v])
        {
            if (dfs(e[i].v, b)) return true;
        }
    }
    return false;
}
*/

bool bfs(int a, int b)
{
    if (a == b) return true;
    int q[N], begin, end;
    begin = 0;
    end = 0;
    q[end++] = a;
    vis[a] = true;
    while (begin != end)
    {
        int x = q[begin++];
        for (int i = head[x]; i != -1; i = e[i].next)
        {
            if (!vis[e[i].v])
            {
                vis[e[i].v] = true;
                if (e[i].v == b) return true;
                q[end++] = e[i].v;
            }
        }
    }
    return false;
}

void workquestion(char* buf)
{
    char n1[20], n2[20];
    int a, b;
    if (sscanf(buf, "can everything which can %s %s", n1, n2) == 2)
    {
        a = getv(n1);
        b = getv(n2);
    }
    else if (sscanf(buf, "are everything which can %s %s", n1, n2) == 2)
    {
        a = getv(n1);
        b = getn(n2);
    }
    else if (sscanf(buf, "are %s %s", n1, n2) == 2)
    {
        a = getn(n1);
        b = getn(n2);
    }
    else if (sscanf(buf, "can %s %s", n1, n2) == 2)
    {
        a = getn(n1);
        b = getv(n2);
    }
    //else assert("workquestion error");
    memset(vis, 0, sizeof(vis));
    if (bfs(a, b)) printf("Y");
    else printf("M");
}

int read()
{
    char buf[200];
    int length;
    while (true)
    {
        gets(buf);
        length = strlen(buf);

        if (buf[length - 1] == '!') return 0;
        else
        if (buf[length - 1] == '.')
        {
            buf[length - 1] = 0;
            workstatement(buf);
        }
        else
        {
            buf[length - 1] = 0;
            workquestion(buf);
        }
    }
}

int main()
{
    //freopen("universal.in","r",stdin);
    int t;
    scanf("%d", &t;);
    getchar();

    for (int tcase = 1; tcase <= t; ++tcase)
    {
        printf("Case #%d:\n", tcase);
        mapcount = 0;
        edgenum = 0;
        memset(head, -1, sizeof(head));
        nmap.clear();
        vmap.clear();

        while (read());
        printf("\n");
    }
    return 0;
}

```

