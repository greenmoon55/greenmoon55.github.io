---
author: admin
comments: true
date: 2010-03-31 11:24:11+00:00
layout: post
slug: usaco-number-triangles
title: USACO Number Triangles
wordpress_id: 192
categories:
- Programming
tags:
- DP
- USACO
---

很简单的DP，边读入边算都行。。
经测试，定义大数组要放到int main外面，原因不懂～

今天下午可折腾坏了。。试用N个IDE，最后用了北航的Guide。。。gdb还不行，似乎是版本过高了，后来又重新下载的。。 
这个似乎是给NOI用的，目前唯一问题是不知道怎么调字体字号。
Code::Blocks现在不能新建工程、Codelite调试窗口是黑的、NetBeans无法编译（唔，现在好像可以啦）。。

```c 

/*
ID: djgreen1
LANG: C
PROB: numtri
*/
#include 
long num[1001][1001];
long max(long a,long b)
{
	if (a>b) return a;
	else return b;
}
int main()
{
    FILE *in=fopen("numtri.in","r"),*out=fopen("numtri.out","w");
    int r,i,j;
	long m=0;

	memset(num,0,sizeof(num));
    fscanf(in,"%d",&r;);
    for (i=1;i<=r;i++)
	for (j=1;j<=i;j++) 
	{
		fscanf(in,"%d",&num;[i][j]);
		num[i][j]+=max(num[i-1][j-1],num[i-1][j]);
	}
    fclose(in);
	for (i=1;i<=r;i++) if (num[r][i]>m) m=num[r][i];
	fprintf(out,"%d\n",m);
	fclose(out);
	return 0;
}

```

