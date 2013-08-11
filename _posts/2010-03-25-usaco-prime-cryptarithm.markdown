---
author: admin
comments: true
date: 2010-03-25 11:12:51+00:00
layout: post
slug: usaco-prime-cryptarithm
title: USACO Prime Cryptarithm
wordpress_id: 189
categories:
- Programming
tags:
- USACO
---

额 字母很乱。。。

    
    
         i j k
       x   a b
    _______________
         e d c
       h g f
    _______________
       n m l
    
    ```
    
    
    ```c 
    
    /*
    ID: djgreen1
    LANG: C
    PROB: crypt1
    */
    #include <stdio.h>
    #include <stdbool.h>
    
    int main()
    {
        int i,j,k,a,b,c,d,e,f,g,h,l,m,n,ans=0,num;
        bool digit[10];
        FILE *in=fopen("crypt1.in","r"),*out=fopen("crypt1.out","w");
        fscanf(in,"%d",&num;);
        memset(digit,0,sizeof(digit));
        for (i=0;i<num;i++) 
        {
            fscanf(in,"%d",&j;);
            digit[j]=true;
        }
        for (i=1;i<10;i++)
        {
            if (!digit[i]) continue;
            for (j=0;j<10;j++)
            {
                if (!digit[j]) continue;
                for (k=0;k<10;k++)
                {
                    if (!digit[k]) continue;
                    for (a=1;a<10;a++)
                    {
                        if (!digit[a]) continue;
                        for (b=0;b<10;b++)
                        {
                            if (!digit[b]) continue;
                            c=k*b;
                            d=c/10;
                            c=c%10;
                            if (!digit[c]) continue;
                            d+=b*j;
                            e=d/10;
                            d=d%10;
                            if (!digit[d]) continue;                        
                            e+=b*i;
                            if (e>9 || e==0 || !digit[e]) continue;
                            
                            f=a*k;
                            g=f/10;
                            f=f%10;
                            if (!digit[f]) continue;
                            g+=a*j;
                            h=g/10;
                            g=g%10;
                            if (!digit[g]) continue; 
                            h+=a*i;
                            if (h>9 || h==0 || !digit[h]) continue;
                            
                            l=d+f;
                            m=l/10;
                            l=l%10;
                            if (!digit[l]) continue;
                            m+=e+g;
                            n=m/10;
                            m=m%10;
                            if (!digit[m]) continue;
                            n+=h;
                            if (n>9 || n==0 || !digit[n]) continue;
                            
                            ans++;
                        }
                    }
                }
            }
        }
        fprintf(out,"%d\n",ans);
        fclose(in);
        fclose(out);
    }
    
    ```
    
