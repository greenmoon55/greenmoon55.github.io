---
author: admin
comments: true
date: 2010-04-03 04:50:41+00:00
layout: post
slug: usaco-prime-palindromes
title: USACO Prime Palindromes
wordpress_id: 195
categories:
- Programming
tags:
- USACO
---

第一个TLE了，枚举所有数，先判断回文，后判断质数。优化了点还是不行。

```c 

/*
ID: djgreen1
LANG: C
PROB: pprime
*/
//This is version 1 TLE
#include 
#include 
#include 
int num[11];
int convert(long n)
{
	int i=0;
	while (n>0)
	{
		num[i]=n%10;
		n=n/10;
		i++;
	}
	return i;
}
bool isprime(long l)
{
	int i,temp;
	temp=sqrt(l);
	for (i=2;i<=temp;i++)
		if (l%i==0) return false;
	return true;
}
int main()
{
	FILE *in=fopen("pprime.in","r"),*out=fopen("pprime.out","w");
	long a,b,i;
	int length,j;
	bool find;
	
	fscanf(in,"%ld%ld",&a;,&b;);
	fclose(in);
	for (i=a;i<=b;i++)
	{
		if (i>11 && i<100) continue;
		if (i>1000 && i<10000) continue;
		if (i>100000 && i<1000000) continue;
		if (i%2==0) continue;
		length=convert(i);
		find=true;
		for (j=0;j<=length/2;j++)
			if (num[j]!=num[length-j-1])
			{
				find=false;
				break;
			}
		if (find)
			if (isprime(i)) fprintf(out,"%ld\n",i);
	}
	fclose(out);
}

```

后来参考USACO的hint，直接生成递增的回文数，循环很巧妙，提前生成10000以内的质数，应该提高了不少效率。
所有偶数位的回文数都能[被11整除](http://zhidao.baidu.com/question/86299975.html)，此时奇数位与偶数位的差为0。
时间很短：不过为啥时间最长的不是Test 9？

    
    
       Test 1: TEST OK [0.022 secs, 1956 KB]
       Test 2: TEST OK [0.000 secs, 1956 KB]
       Test 3: TEST OK [0.022 secs, 1956 KB]
       Test 4: TEST OK [0.000 secs, 1956 KB]
       Test 5: TEST OK [0.011 secs, 1956 KB]
       Test 6: TEST OK [0.000 secs, 1956 KB]
       Test 7: TEST OK [0.011 secs, 1956 KB]
       Test 8: TEST OK [0.011 secs, 1956 KB]
       Test 9: TEST OK [0.011 secs, 1956 KB]
    
    ```
    
    
    ```C 
    
    /*
    ID: djgreen1
    LANG: C
    PROB: pprime
    */
    #include <stdio.h>
    #include <stdbool.h>
    #include <math.h>
    
    int prime[10000];
    bool isp[10000];
    int num[11],pnum;
    
    bool isprime(long l)
    {
    	int i;
    	for (i=0;i<pnum;i++)
    	{
    		if (prime[i]>sqrt(l)) break;
    		if (l%prime[i]==0) return false;
    	}
    	return true;
    }
    void init()
    {
    	int i,j;
    	memset(isp,true,sizeof(isp));
    	for (i=2;i<100;i++)
    		if (isp[i])
    			for (j=2;j<=10000/i;j++) isp[i*j]=false;
    	j=0;
    	for (i=2;i<10000;i++)
    		if (isp[i])
    		{
    			prime[j]=i;
    			j++;
    		}
    	pnum=j;
    }
    int main()
    {
    	FILE *in=fopen("pprime.in","r"),*out=fopen("pprime.out","w");
    	long a,b,temp;
    	int i,j,k,l;
    	
    	fscanf(in,"%ld%ld",&a;,&b;);
    	fclose(in);
    	init();
    	
    	//single-digit number
    	for (i=5;i<10;i++) 
    	{
    		if (i<a) continue;
    		if (i>b)
    		{
    			fclose(out);
    			return 0;
    		}
    		if (isprime(i)) fprintf(out,"%d\n",i);
    	}
    	//11
    	if (11>=a && 11<=b) fprintf(out,"11\n");
    	//3-digit number
    	for (i=1;i<=9;i+=2)
    		for (j=0;j<=9;j++) 
    		{
    			temp=i*101+j*10;
    			if (temp<a) continue;
    			if (temp>b)
    			{
    				fclose(out);
    				return 0;
    			}
    			if (isprime(temp)) fprintf(out,"%ld\n",temp);
    		}
    	//5-digit number
    	for (i=1;i<=9;i+=2)
    		for (j=0;j<=9;j++)
    			for (k=0;k<=9;k++)
    			{
    				temp=i*10001+j*1010+k*100;
    				if (temp<a) continue;
    				if (temp>b)
    				{
    					fclose(out);
    					return 0;
    				}
    				if (isprime(temp)) fprintf(out,"%ld\n",temp);
    			}
    	//7-digit number
    	for (i=1;i<=9;i+=2)
    		for (j=0;j<=9;j++)
    			for (k=0;k<=9;k++)
    				for (l=0;l<=9;l++)
    				{
    					temp=i*1000001+j*100010+k*10100+l*1000;
    					if (temp<a) continue;
    					if (temp>b)
    					{
    						fclose(out);
    						return 0;
    					}
    					if (isprime(temp)) fprintf(out,"%ld\n",temp);
    				}
    	fclose(out);
    	return 0;
    }
    
    ```
    
