---
author: admin
comments: true
date: 2010-04-04 07:16:35+00:00
layout: post
slug: usaco-superprime-rib
title: USACO Superprime Rib
wordpress_id: 197
categories:
- Programming
tags:
- USACO
---

这题和昨天那个差不多，DFS找质数即可。
最开始把prime数组开到10000，出现了很怪异的问题：运行完init()会把n归零。。
还学会了[用freopen](http://www.slyar.com/blog/c-freopen-stdin-stdout.html)，否则没法再其他地方输出。还是要写fclose的。

```c 

/*
ID: djgreen1
LANG: C
PROB: sprime
*/
#include 
#include 
#include 

bool prime[10001];
int num[10000],sum;
int n;
void init()
{
	int i,j;
	memset(prime,true,sizeof(prime));
	for (i=2;i<100;i++)
	{
		if (prime[i])
			for (j=2;j<=10000/i;j++) prime[i*j]=false;
	}
	j=0;
	for (i=2;i<10000;i++)
		if (prime[i])
		{
			j++;
			num[j]=i;
		}
	sum=j;
}
bool isprime(long a)
{
	int i;
	for (i=1;i<=sum;i++)
	{
		if (num[i]>sqrt(a)) return true;
		if (a%num[i]==0) return false;
	}
	return true;
}
void search(long a,int depth)
{
	long temp;
	int i;
	
	if (depth==n)
	{
		printf("%ld\n",a);
		return;
	}
	for (i=1;i<10;i+=2)
	{
		temp=a*10+i;
		if (isprime(temp)) search(temp,depth+1);
	}
}
int main()
{
	freopen("sprime.in", "r", stdin);
	freopen("sprime.out", "w", stdout);
	
	scanf("%d",&n;);
	init();
	search(2,1);
	search(3,1);
	search(5,1);
	search(7,1);
	fclose(stdin);
	fclose(stdout);
}

```

