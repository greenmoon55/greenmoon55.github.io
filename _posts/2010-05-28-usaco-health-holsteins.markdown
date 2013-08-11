---
author: admin
comments: true
date: 2010-05-28 06:19:21+00:00
layout: post
slug: usaco-health-holsteins
title: USACO Health Holsteins
wordpress_id: 209
categories:
- Programming
tags:
- USACO
---

简单题。。。DFS

```c 

/*
ID: djgreen1
PROB: holstein
LANG: C
*/
#include 
#include 
int temp[26]={0};
bool used[16]={0};
int num=0,max=999,v,g,min[26],feed[16][26],ans[16];
void work(int n)
{
	int i,j;
	bool ok=true;
	if (n>g) return;
	for (i=1;i<=v;i++)
	{
		temp[i]+=feed[n][i];
		if (temp[i]<min[i]) ok=false;
	}
	used[n]=true;
	num++;
	if (ok)
	{
		if (num<max)
		{
			max=num;
			j=0;
			for (i=1;i<=n;i++) if (used[i]) 
			{
				j++;
				ans[j]=i;
			}
		}
		used[n]=false;
		num--;
		for (i=1;i<=v;i++) temp[i]-=feed[n][i];
		return;
	}
	else
	{
		work(n+1);
		used[n]=false;
		num--;
		for (i=1;i<=v;i++) temp[i]-=feed[n][i];
		work(n+1);
	}
}
int main()
{
	freopen("holstein.in","r",stdin);
	freopen("holstein.out","w",stdout);
	
	int i,j;
	
	scanf("%d",&v;);
	for (i=1;i<=v;i++) scanf("%d",&min;[i]);
	scanf("%d",&g;);
	for (i=1;i<=g;i++) 
		for (j=1;j<=v;j++) scanf("%d",&feed;[i][j]);
	work(1);
	printf("%d ",max);
	for (i=1;i<max;i++) printf("%d ",ans[i]);
	printf("%d\n",ans[max]);
	return 0;
}

```

