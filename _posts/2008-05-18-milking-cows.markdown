---
author: admin
comments: true
date: 2008-05-18 09:59:43+00:00
layout: post
slug: milking-cows
title: Milking Cows
wordpress_id: 45
categories:
- Programming
tags:
- USACO
---

翻译：[http://www.nocow.cn/index.php/Translate:USACO/milk2](http://www.nocow.cn/index.php/Translate:USACO/milk2)

先qsort，然后把每小段的起始存起来，再循环找一下就行。神奇的是，我qsort都打错了却过了6组。。:D

----------
**UPDATE @ 2010/3/12 17:19** 当年发错程序了，删掉了。
今天做的这个最开始总是不对，本机没问题，传上去就出错。后来发现不能写成bool time[1000001]={0}，用了memset，MS用法和pascal里的fillchar一样。time[i]表示从i到i+1的时间被占用，这应该是最白痴的做法了。
**UPDATE @ 2010/3/25 18:51**memset好像用错了。。好像是memset(**,0,sizeof(**))。。


```c 

/*
ID: djgreen1
LANG: C
TASK: milk2
*/
#include 
#include 

int main()
{
    bool time[1000001];
    int i,n;
    long j,a,b;
    long low,high,count[2],max[2];
    FILE *in=fopen("milk2.in","r"),*out=fopen("milk2.out","w");
    
    memset(time,sizeof(time),false);
    low=1000000;
    high=1;
    max[1]=0;
    max[0]=0;
    count[1]=0;
    count[0]=0;
    fscanf(in,"%d\n",&n;);
    for(i=0;i<n;i++)
    {
        fscanf(in,"%d %d",&a;,&b;);
        if(a<low) low=a;
        if(b>high) high=b;
        for(j=a;j<b;j++) time[j]=true;
    }
    for(j=low;j<=high;j++)
    {
        count[time[j]]++;
        if(time[j+1]!=time[j])
        {
            if(count[time[j]]>max[time[j]]) max[time[j]]=count[time[j]];       
            count[time[j]]=0;
        }
    }
    fprintf(out,"%d %d\n",max[1],max[0]);
    fclose(in);
    fclose(out);
}

```


----------
**UPDATE @ 2010/3/13 21:38**
C语言的struct、随机快排。

```c 

/*
ID: djgreen1
LANG: C
TASK: milk2
*/
#include 
#include  

struct time
{
    long a,b;
};
struct time milk[5000];
void quicksort(long l, long r)
{
    long i,j,pivot;
    struct time temp;
    pivot=milk[rand()%(r-l+1)+l].a;
    i=l;
    j=r;
    while(i<j)
    {
        while(milk[j].a>pivot) j--;
        while(milk[i].a<pivot) i++;
        if (i<=j)
        {
            temp=milk[i];
            milk[i]=milk[j];
            milk[j]=temp;
            i++;
            j--;
        }
    }
    if (i<r) quicksort(i,r);
    if (j>l) quicksort(l,j);
}

int main()
{
    FILE *in=fopen("milk2.in","r"),*out=fopen("milk2.out","w");
    int i,n;
    long start,end,work,idle=0;
    
    fscanf(in,"%d",&n;);
    srand(time(NULL));
    for (i=0;i<n;i++) fscanf(in,"%d%d",&milk;[i].a,&milk;[i].b);
    quicksort(0,n-1);
    start=milk[0].a;
    end=milk[0].b;
    work=end-start;
    for (i=0;i<n;i++)
    {
        if (milk[i].a>end)
        {
            if (end-start>work) work=end-start;
            if (milk[i].a-end>idle) idle=milk[i].a-end;
            start=milk[i].a;
            end=milk[i].b;
        }
        else
        {
            if (milk[i].b>end) end=milk[i].b;
        }
    }
    fprintf(out,"%d %d\n",work,idle);
    fclose(in);
    fclose(out);
}

```

