---
author: admin
comments: true
date: 2010-05-27 10:11:20+00:00
layout: post
slug: usaco-ordered-fractions
title: USACO Ordered Fractions
wordpress_id: 207
categories:
- Programming
tags:
- USACO
---

求值排序

```c 
/*
ID:djgreen1
PROG:frac1
LANG:C
*/
#include
#include
struct num
{
	int a,b;
	double value;
};
bool prime[200];
bool work(int a,int b)
{
	int i;
	for (i=2;i<=a;i++)
		if (prime[i])
		{
			if (a%i==0&&b%i==0) return false;
		}
	return true;
}
int main()
{
	freopen("frac1.in","r",stdin);
	freopen("frac1.out","w",stdout);
	int i,j,n,count;
	struct num frac[25600],temp;

	memset(prime,true,sizeof(prime));
	for (i=2;i<160;i++)
		if (prime[i])
		{
			for (j=2;j<=160/i;j++) prime[i*j]=0;
		}
	scanf("%d",&n);
	printf("0/1\n");
	if (n==2)
	{
		printf("1/2\n1/1\n");
		return 0;
	}
	count=0;

	//generate all fractions
	for (i=1;i<=n;i++)
		for (j=i+1;j<=n;j++)
		{
			if (!work(i,j)) continue; //gcd
			count++;
			frac[count].a=i;
			frac[count].b=j;
			frac[count].value=(double)i/(double)j;
		}

	//sort
	for (i=1;ifrac[j].value)
		{
			temp=frac[i];
			frac[i]=frac[j];
			frac[j]=temp;
		}
	for (i=1;i<=count;i++)
	{
		printf("%d/%d\n",frac[i].a,frac[i].b);
	}
	printf("1/1\n");
	fclose(stdin);
	fclose(stdout);
	return 0;
}

```

有种方法很简单，根据

    
    a/b<c/d==>a/b<(a+c)/(b+d)<c/d
    ```
    
    （通分可证，更深奥的就不懂了- -!）USACO给的答案：
    
    
    ```c 
    
    /* print the fractions of denominator <= n between n1/d1 and n2/d2 */
    void
    genfrac(int n1, int d1, int n2, int d2)
    {
    	if(d1+d2 > n)	/* cut off recursion */
    		return;
     
    	genfrac(n1,d1, n1+n2,d1+d2);
    	fprintf(fout, "%d/%d\n", n1+n2, d1+d2);
    	genfrac(n1+n2,d1+d2, n2,d2);
    }
    }
    
    ```
    
