---
author: admin
comments: true
date: 2010-03-30 05:15:50+00:00
layout: post
slug: usaco-arithmetic-progressions
title: USACO Arithmetic Progressions
wordpress_id: 191
categories:
- Programming
tags:
- USACO
---

时间限制为5秒。。
   Test 1: TEST OK [0.000 secs, 1952 KB]
   Test 2: TEST OK [0.000 secs, 1952 KB]
   Test 3: TEST OK [0.011 secs, 1956 KB]
   Test 4: TEST OK [0.011 secs, 1956 KB]
   Test 5: TEST OK [0.011 secs, 1956 KB]
   Test 6: TEST OK [0.162 secs, 1956 KB]
   Test 7: TEST OK [2.106 secs, 1960 KB]
   Test 8: TEST OK [4.752 secs, 1952 KB]
   Test 9: TEST OK [4.352 secs, 1952 KB]

先搜公差再搜首项就不用排序了。。显然速度很慢。4.752s...

    
    
    /*
    ID: djgreen1
    LANG: C
    PROB: ariprog
    */
    #include <stdio.h>
    #include <stdbool.h>
    
    int main()
    {
        long n,m,i,j,mm,nn,a,b;
        FILE *in=fopen("ariprog.in","r"),*out=fopen("ariprog.out","w");
        bool bisquare[125001],find,none=true;
        
        memset(bisquare,false,sizeof(bisquare));
        fscanf(in,"%d%d",&n;,&m;);
        for (i=0;i<=m;i++)
            for (j=i;j<=m;j++) bisquare[i*i+j*j]=true;
        mm=m*m;
        for (b=1;b<=mm;b++)
        {
            nn=m*m*2-b*(n-1);
            for (a=0;a<=nn;a++)
            {
                if (bisquare[a])
                {
                    find=true;
                    for (i=n-1;i>0;i--) 
                        if (!bisquare[a+b*i]) 
                        {
                            find=false;
                            break;
                        }    
                    if (find) 
                    {
                        fprintf(out,"%d %d\n",a,b);
                        none=false;
                    }    
                }
            }
        }
        if (none) fprintf(out,"NONE\n");
        fclose(in);
        fclose(out);            
    }
    
    ```
    
    
