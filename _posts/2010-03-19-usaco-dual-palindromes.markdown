---
author: admin
comments: true
date: 2010-03-19 11:50:12+00:00
layout: post
slug: usaco-dual-palindromes
title: USACO Dual Palindromes
wordpress_id: 180
categories:
- Programming
tags:
- USACO
---

昨天做的，本来以为很快就能打完。原来是“if (ispal()) sum++;”忘记打ispal的括号了。。调了很久，ispal返回值一直是一个固定的大数。调好后USACO就挂了。。

```c

/*
ID: djgreen1
LANG: C
PROB: dualpal
*/
#include 
#include 

int p,new[20];
void convert(int num, int base)
{
    p=0;
    while (true)
    {
        new[p]=num%base;
        num=num/base;
        if (num==0) break;
        p++;
    }
}
bool ispal()
{
    int j;
    for (j=0;j<=p;j++)
    {
        if (new[j]!=new[p-j])
        {
            return(0);
        }
    }
    return(1);
}
int main()
{
    FILE *in=fopen("dualpal.in","r"),*out=fopen("dualpal.out","w");
    int n,s,sum,find=0,i;

    fscanf(in,"%d%d",&n;,&s;);
    while (find<n)
    {
        s++;
        sum=0;
        for (i=2;i<=10;i++)
        {
            convert(s,i);
            if (ispal()) sum++;
            if (sum==2)
            {
                fprintf(out,"%d\n",s);
                find++;
                break;
            }
        }
    }
    fclose(in);
    fclose(out);
    return 0;
}

```

