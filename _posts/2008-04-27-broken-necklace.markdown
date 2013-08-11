---
author: admin
comments: true
date: 2008-04-27 14:21:27+00:00
layout: post
slug: broken-necklace
title: Broken Necklace
wordpress_id: 37
categories:
- Programming
tags:
- USACO
---

翻译： [http://www.nocow.cn/index.php/Translate:USACO/beads](http://www.nocow.cn/index.php/Translate:USACO/beads)

大概思路就是复制3遍，然后在中间那段一个一个找，如果找过头了就ans:=n。 :)

My program:

```pascal 

{
ID: djgreen1
PROG: beads
LANG: PASCAL
}
program beads;
var
		n: longint;
		a: array[0..1050] of char;
		ans: longint;
procedure init;
var
		i: longint;
begin
		readln(n);
		for i := 1 to n do
		begin
				read(a[i]);
				a[i + n] := a[i];
				a[i + n * 2] := a[i];
		end;
		readln;
end;
procedure work;
var
		i, j, k: longint;
		first, second: char;
begin
		for i := n * 2 downto n + 1 do
		begin
				j := i + 1;
				while (a[j] = 'w') and (j <= i + n * 2) do inc(j);
				first := a[j];
				while (a[j] = first) or (a[j] = 'w') do inc(j);
				k := i;
				while (a[k] = 'w') and (k > 0) do dec(k);
				first := a[k];
				while (a[k] = first) or (a[k] = 'w') do dec(k);
				if ans < j - k - 1 then ans := j - k - 1;
		end;
end;
begin
		ans := 0;
		assign(input, 'beads.in');
		assign(output, 'beads.out');
		reset(input);
		init;
		close(input);
		work;
		if ans > n then ans := n;
		rewrite(output);
		writeln(ans);
		close(output);
end.

```


Update @ 2010/3/10 20:37 用C重写了，没优化什么就过了。

```c 

/*
ID: djgreen1
LANG: C
TASK: beads
*/

#include 

int main()
{
    FILE *in=fopen("beads.in","r"),*out=fopen("beads.out","w");
    int n,i,breakpoint,length1,length2,num=0,point;
    char bead[1051]={0},color[1];
    
    fscanf(in,"%d\n",&n;);
    fscanf(in,"%s",bead);
    
    for(i=n;i<2*n;i++) bead[i]=bead[i-n];
    for(;i<3*n;i++) bead[i]=bead[i-n];
    
    for(breakpoint=n;breakpoint<=n*2;breakpoint++)
    {
        length1=0;
        point=breakpoint-1;
        while (bead[point]=='w' && point>=0) 
        {
              length1++;
              point--;
        }
        color[0]=bead[point];
        for(i=point;i>=0;i--)
        {
            if (bead[i]==color[0] || bead[i]=='w') length1++;
            else break;
        }
        length2=0;
                
        point=breakpoint;
        while (bead[point]=='w' && point<=n*3)
        {
              length2++;
              point++;
        }
        color[0]=bead[point];
        for(i=point;i<=n*3;i++)
        {
            if (bead[i]==color[0] || bead[i]=='w') length2++;
            else break;
        }
        if (length1+length2>num) num=length1+length2;
    }
    if (num>n) num=n;
    fprintf(out,"%d\n",num);
    fclose(in);
    fclose(out);
}

```

