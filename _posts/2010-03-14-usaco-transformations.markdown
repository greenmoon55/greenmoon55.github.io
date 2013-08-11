---
author: admin
comments: true
date: 2010-03-14 11:31:28+00:00
layout: post
slug: usaco-transformations
title: USACO Transformations
wordpress_id: 177
categories:
- Programming
tags:
- USACO
---

这题当时（08年！）没做，有点麻烦，数据才10*10，慢慢算就行。
PS：从Dev-C++换到了Code:Blocks，前者调试时很费劲，容易崩溃。适应中...
看F1去鸟^_^

    
    
    /*
    ID: djgreen1
    LANG: C
    PROB: transform
    */
    #include <stdio.h>
    #include <stdbool.h>
    #include <string.h>
    int main()
    {
        int n,i,j;
        char s1[11][11]={0},s2[11][11]={0};
        bool skip;
        FILE *in=fopen("transform.in","r"),*out=fopen("transform.out","w");
    
        skip=false;
        fscanf(in,"%d\n",&n;);
        for (i=0;i<n;i++) fscanf(in,"%s\n",s1[i]);
        for (i=0;i<n;i++) fscanf(in,"%s\n",s2[i]);
    
        //Case 1
        for (i=0;i<n;i++)
        {
            for (j=0;j<n;j++)
            if (s1[i][j]!=s2[j][n-i-1])
            {
                skip=true;
                break;
            }
            if (skip) break;
        }
        if (!skip)
        {
            fprintf(out,"1\n");
            return 0;
        }
    
        //Case 2
        skip=false;
        for (i=0;i<n;i++)
        {
            for (j=0;j<n;j++)
            if (s1[i][j]!=s2[n-i-1][n-j-1])
            {
                skip=true;
                break;
            }
            if (skip) break;
        }
        if (!skip)
        {
            fprintf(out,"2\n");
            return 0;
        }
    
        //Case 3
        skip=false;
        for (i=0;i<n;i++)
        {
            for (j=0;j<n;j++)
            if (s2[i][j]!=s1[j][n-i-1])
            {
                skip=true;
                break;
            }
            if (skip) break;
        }
        if (!skip)
        {
            fprintf(out,"3\n");
            return 0;
        }
    
        //Case 4
        skip=false;
        for (i=0;i<n;i++)
        {
            for (j=0;j<n;j++)
            if (s1[i][j]!=s2[i][n-j-1])
            {
                skip=true;
                break;
            }
            if (skip) break;
        }
        if (!skip)
        {
            fprintf(out,"4\n");
            return 0;
        }
    
        //Case 5
        skip=false;
        for (i=0;i<n;i++)
        {
            for (j=0;j<n;j++)
            if (s1[i][n-j-1]!=s2[j][n-i-1])
            {
                skip=true;
                break;
            }
            if (skip) break;
        }
        if (skip)
        {
            skip=false;
            for (i=0;i<n;i++)
            {
                for (j=0;j<n;j++)
                if (s1[i][n-j-1]!=s2[n-i-1][n-j-1])
                {
                    skip=true;
                    break;
                }
                if (skip) break;
            }
        }
        if (skip)
        {
            skip=false;
            for (i=0;i<n;i++)
            {
                for (j=0;j<n;j++)
                if (s2[i][j]!=s1[n-j-1][n-i-1])
                {
                    skip=true;
                    break;
                }
                if (skip) break;
            }
        }
        if (!skip)
        {
            fprintf(out,"5\n");
            return 0;
        }
    
        //Case 6
        skip=false;
        for (i=0;i<n;i++)
        {
            for (j=0;j<n;j++)
            if (s1[i][j]!=s2[i][j])
            {
                skip=true;
                break;
            }
            if (skip) break;
        }
        if (!skip) fprintf(out,"6\n");
        else fprintf(out,"7\n");
        return 0;
    }
    
    ```
    
