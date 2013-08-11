---
author: admin
comments: true
date: 2010-03-08 12:56:23+00:00
layout: post
slug: greedy-gift-givers
title: Greedy Gift Givers
wordpress_id: 175
categories:
- Programming
tags:
- USACO
---

身体不太舒服，这题弄了好久。。
学到了：={0}好像可以初始化，strcmp是比较字符串的函数，相等时值为0。

```c 

/*
ID: djgreen1
LANG: C
TASK: gift1
*/

#include 
int main()
{
    int n,i,j,k,money[11]={0},give,num,income;
    char name[11][15]={0},people[15]={0};
    FILE *in=fopen("gift1.in","r"),*out=fopen("gift1.out","w");
    
    
    fscanf(in,"%d",&n;);
    for(i=0;i<n;i++)
        fscanf(in,"%s",name[i]);
    for(i=0;i<n;i++)
    {
        fscanf(in,"%s",people);
        for(j=0;j<n;j++) 
        {
            if (!strcmp(people,name[j])) break;
        }        
        fscanf(in,"%d%d",&income;,&num;);
        if (!num==0)
        {
            give=income/num;
            money[j]=money[j]-give*num;
            for(j=1;j<=num;j++)
                {
                fscanf(in,"%s",people);
                for(k=0;k<n;k++) if (!strcmp(people,name[k])) break;
                money[k]=money[k]+give;
                }
        }  
    }
    for(i=0;i<n;i++) fprintf(out,"%s %d\n",name[i],money[i]);
    exit(0);
}

```

