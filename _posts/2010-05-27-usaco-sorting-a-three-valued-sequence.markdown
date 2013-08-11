---
author: admin
comments: true
date: 2010-05-27 15:09:02+00:00
layout: post
slug: usaco-sorting-a-three-valued-sequence
title: USACO Sorting a Three-Valued Sequence
wordpress_id: 208
categories:
- Programming
tags:
- USACO
---

自己的想法错了。。第六组过不去，后来参照[OIBH](http://oibh.org/bbs/viewthread.php?tid=10411&page=5#pid290439)了。
可以这样理解，先把3放好，对于1、2位置，如果{1在2上，2在1上}互相交换即可，否则要和新换上的数字交换。。
比如：

    
    
    3
    1
    2
    
    ```
    
    要交换两次。
    
    
    ```c 
    
    /*
    ID: djgreen1
    PROB: sort
    LANG: C
    */
    #include <stdio.h>
    int max(int a, int b)
    {
    	if (a>b) return a;
    		else return b;
    }
    int main()
    {
    	freopen("sort3.in","r",stdin);
    	freopen("sort3.out","w",stdout);
    	
    	int i,n,num[1002]={0},count[4]={0},ans[4]={0},end;
    	
    	scanf("%d",&n;);
    	for (i=1;i<=n;i++)
    	{
    		scanf("%d",&num;[i]);
    		count[num[i]]++;
    	}
    	for (i=1;i<=count[1];i++) 
    	{
    		if (num[i]==3) 
    		{
    			ans[3]++;
    			continue;
    		}
    		if (num[i]==2) ans[2]++;
    	}	
    	end=count[1]+count[2];
    	for (i=count[1]+1;i<=end;i++) 
    	{
    		if (num[i]==3) 
    		{
    			ans[3]++;
    			continue;
    		}
    		if (num[i]==1) ans[1]++;
    	}
    	printf("%d\n",ans[3]+max(ans[1],ans[2]));
    	fclose(stdin);
    	fclose(stdout);
    	return 0;
    }
    
    ```
    
