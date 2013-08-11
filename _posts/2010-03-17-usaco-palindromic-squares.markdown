---
author: admin
comments: true
date: 2010-03-17 05:30:23+00:00
layout: post
slug: usaco-palindromic-squares
title: USACO Palindromic Squares
wordpress_id: 179
categories:
- Programming
tags:
- USACO
---

"We generate all the squares from 1 to 300 and check to see which are palindromes. "
慢慢算就是了～不过不太熟悉C的函数、过程什么的，没用到。

    
    
    /*
    ID: djgreen
    LANG: C
    PROB: palsquare
    */
    
    #include <stdio.h>
    #include <stdbool.h>
    
    const char s[20]={'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F','G','H','I','J'};
    int main()
    {
        FILE *in=fopen("palsquare.in","r"),*out=fopen("palsquare.out","w");
        int base,n,new[17],old[17],p,p2,i,temp;
        long num;
        bool find;
    
        fscanf(in,"%d",&base;);
        fclose(in);
        for (n=1;n<=300;n++)
        {
            num=n*n;
    
            //convert(num)
            p=0;
            while (true)
            {
                new[p]=num%base;
                num=num/base;
                if (num==0) break;
                p++;
            }
    
            //palindromic?
            p2=0;
            find=true;
            for (i=0;i<=p;i++)
            {
                if (new[i]!=new[p-i])
                {
                    find=false;
                    break;
                }
            }
            if (find)
            {
                temp=n;
                while (true)
                {
                    old[p2]=temp%base;
                    temp=temp/base;
                    if (temp==0) break;
                    p2++;
                }
                for (i=p2;i>=0;i--) fprintf(out,"%c",s[old[i]]);
                fprintf(out," ");
                for (i=0;i<=p;i++) fprintf(out,"%c",s[new[i]]);
                fprintf(out,"\n");
            }
        }
        fclose(out);
    }
    
    ```
    
