---
author: admin
comments: true
date: 2010-03-24 13:45:48+00:00
layout: post
slug: usaco-calf-flac
title: USACO Calf Flac
wordpress_id: 188
categories:
- Programming
tags:
- USACO
---

从前面一个一个搜就行，枚举回文串的中点，注意奇偶两种情况。
   Test 1: TEST OK [0.000 secs, 1956 KB]
   Test 2: TEST OK [0.000 secs, 1952 KB]
   Test 3: TEST OK [0.011 secs, 1948 KB]
   Test 4: TEST OK [0.000 secs, 1948 KB]
   Test 5: TEST OK [0.011 secs, 1952 KB]
   Test 6: TEST OK [0.011 secs, 1952 KB]
   Test 7: TEST OK [0.011 secs, 1952 KB]
   Test 8: TEST OK [0.076 secs, 1952 KB]
今天折腾了好久，好几个IDE都弄不好。。
﻿﻿
    
    
    /*
    ID: djgreen1
    LANG: C
    PROB: calfflac
    */
    #include <stdio.h>
    #include <stdbool.h>
    bool compare(char ch1,char ch2)
    {
        if (ch1==ch2 || (int)ch1+32==ch2 || (int)ch2+32==ch1) return true;
        else return false;
    }
    int main()
    {
        char code[20001],temp,real[20001];
        int i,j,sum,a,length,ans,tempbegin,tempend,p[20001];
        FILE *in=fopen("calfflac.in","r"),*out=fopen("calfflac.out","w");
        i=0;
        j=0;
        while (fscanf(in,"%c",&code;[i])!=EOF)
        {
            if (((int)code[i]>64 && (int)code[i]<91) || ((int)code[i]>96 && (int)code[i]<123))
            {
                real[j]=code[i];
                p[j]=i;
                j++;
            }
            i++;
        }
        ans=0;
        for (a=0;a<j;a++)
        {
            length=1;
            while (a-length>=0 && a+length<j)
            {
                if (compare(real[a-length],real[a+length])) length++;
                else break;
            }
            if (length*2-1>ans)
            {
                ans=length*2-1;
                tempbegin=a-length+1;
                tempend=a+length-1;
            }
            length=0;
            while (a-length>=0 && a+length+1<j)
            {
                if (compare(real[a-length],real[a+length+1])) length++;
                else break;
            }
            if (length*2>ans) 
            {
                ans=length*2;
                tempbegin=a-length+1;
                tempend=a+length;
            }
        }
        fprintf(out,"%d\n",ans);
        for(a=p[tempbegin];a<=p[tempend];a++) fprintf(out,"%c",code[a]);
        fprintf(out,"\n");
        fclose(in);
        fclose(out);
    }
    
    ```
    
