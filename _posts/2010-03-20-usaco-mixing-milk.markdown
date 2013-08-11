---
author: admin
comments: true
date: 2010-03-20 08:25:41+00:00
layout: post
slug: usaco-mixing-milk
title: USACO Mixing Milk
wordpress_id: 181
categories:
- Programming
tags:
- USACO
---

快排+贪心，还要注意0 0的情况。。

```c 

/*
ID: djgreen1
LANG: C
PROB: milk
*/
#include 
long a[5000],p[5000];
void qsort(int l,int r)
{
	int i,j,pivot;
	long temp;
	i=l;
	j=r;
	pivot=p[rand()%(r-l+1)+l];
	while (i<j)
	{
		while (p[i]<pivot) i++;
		while (p[j]>pivot) j--;
		if (i<=j)
		{
			temp=p[i];
			p[i]=p[j];
			p[j]=temp;
			temp=a[i];
			a[i]=a[j];
			a[j]=temp;
			i++;
			j--;
		}
	}
	if (j>l) qsort(l,j);
	if (i<r) qsort(i,r);
}
int main()
{
	FILE *in=fopen("milk.in","r"),*out=fopen("milk.out","w");
	long n,m,i,milk=0,price=0;

	fscanf(in,"%d%d",&n;,&m;);
	if (n==0)
	{
	    fprintf(out,"0\n");
	    fclose(out);
	    return 0;
	}
	for(i=0;i<m;i++) fscanf(in,"%d%d",&p;[i],&a;[i]);
	fclose(in);
	srand(time(NULL));
	qsort(0,m-1);
	for(i=0;i<m;i++)
	{
	    if (milk+a[i]<n)
	    {
	        milk+=a[i];
	        price+=p[i]*a[i];
	    }
	    else
	    {
	        price+=(n-milk)*p[i];
	        break;
	    }
	}
	fprintf(out,"%d\n",price);
	fclose(out);
}

```

