---
author: admin
comments: true
date: 2010-03-22 15:21:04+00:00
layout: post
slug: usaco-barn-repair
title: USACO Barn Repair
wordpress_id: 184
categories:
- Programming
tags:
- USACO
---

这题做得真纠结，第五次才AC。
刚想起来其实排序可以优化一点点。。
输入数据不是有序的，要先排序！我的算法就是先铺上木板再去掉最大的那几个空隙。
前后改来改去，写得很乱。还要注意m很大的情况。

    
    
    /*
    ID: djgreen1
    LANG: C
    PROB: barn1
    */
    #include <stdio.h>
    
    int main()
    {
        int m,s,c,num[200],data[200],first,i,j,p=1,pnum=0,a,sum,gap,t;
        FILE *in=fopen("barn1.in","r"),*out=fopen("barn1.out","w");
        
        fscanf(in,"%d%d%d",&m;,&s;,&c;);
        for(i=1;i<=c;i++) fscanf(in,"%d",&data;[i]);
        //sort
        for(i=1;i<c;i++)
        for(j=1;j<c;j++) if (data[j]>data[j+1])
        {
            t=data[j+1];
            data[j+1]=data[j];
            data[j]=t;
        }    
        first=data[1];
        a=first;
        for(i=2;i<=c;i++)
        {
            if (data[i]>i-p+first)
            {
                gap=data[i]-(i-p+first);
                num[pnum]=gap;
                pnum++;
                first=data[i];
                p=i;
            }
        }
        
        //sort
        for(i=pnum-1;i>0;i--)
        for(j=pnum-1;j>0;j--) if (num[j]>num[j-1])
        {
            t=num[j-1];
            num[j-1]=num[j];
            num[j]=t;
        }    
        sum=data[c]-a+1;
        if (m>pnum+1) m=pnum+1;
        for(i=0;i<m-1;i++) sum=sum-num[i];
        fprintf(out,"%d\n",sum);
        fclose(in);
        fclose(out);
    }
    
    ```
    
