---
author: admin
comments: true
date: 2008-05-01 01:32:33+00:00
layout: post
slug: friday-the-thirteenth
title: Friday the Thirteenth
wordpress_id: 39
categories:
- Programming
tags:
- USACO
---

翻译：[http://www.nocow.cn/index.php/USACO/friday](http://www.nocow.cn/index.php/USACO/friday)

最简单的方法就能AC，一个月一个月算，我也是这样算的。[这里](http://www.nocow.cn/index.php/USACO/friday)提到可以按年算，想法不错。注意年份是1900+N-1。


```pascal 

{
ID: djgreen1
PROG: friday
LANG: PASCAL
}
program friday;
var
        n: longint;
        sum: array[0..6] of longint;
        date: longint;
        i: longint;
function leap(year: longint): boolean;
begin
        if (year mod 4 = 0) and (year mod 100 > 0) then leap := true
        else if year mod 400 = 0 then leap := true
        else leap := false;
end;
begin
        assign(input, 'friday.in');
        assign(output, 'friday.out');
        reset(input);
        rewrite(output);
        fillchar(sum, sizeof(sum), 0);
        readln(n);
        date := 6;
        for i := 1 to n do
        begin
                date := date mod 7;
                inc(sum[date]);
                date := date + 3;
                date := date mod 7;
                inc(sum[date]);
                if leap(1899 + i) then inc(date);
                date := date mod 7;
                inc(sum[date]);
                date := date + 3;
                date := date mod 7;
                inc(sum[date]);
                date := date + 2;
                date := date mod 7;
                inc(sum[date]);
                date := date + 3;
                date := date mod 7;
                inc(sum[date]);
                date := date + 2;
                date := date mod 7;
                inc(sum[date]);
                date := date + 3;
                date := date mod 7;
                inc(sum[date]);
                date := date + 3;
                date := date mod 7;
                inc(sum[date]);
                date := date + 2;
                date := date mod 7;
                inc(sum[date]);
                date := date + 3;
                date := date mod 7;
                inc(sum[date]);
                date := date + 2;
                date := date mod 7;
                inc(sum[date]);
                date := date + 3;

        end;
        write(sum[6]);
        for i := 0 to 5 do write(' ', sum[i]);
        writeln;
        close(input);
        close(output);
end.

```

<!-- more -->
**UPDATE @ 2010/3/9/15:05**
C语言不能用mod，要用%。。这样判断闰年很简洁，网上搜来的。

```c 

/*
ID: djgreen1
LANG: C
TASK: friday
*/
#include 
#include 

bool leapyear (int year)
{
     return ((year%4==0 && year%100>0) || (year%400==0));
}
int main()
{
    FILE *in=fopen("friday.in","r"),*out=fopen("friday.out","w");
    int n,i,sum[8]={0},day;
    
    fscanf(in,"%d",&n;);
    day=6;
    for(i=0;i<n;i++)
    {
        sum[day]++;//1.13
        day=day+3;
        day=day%7;
        sum[day]++;//2.13
        if (leapyear(1900+i)) day=day+1;
        day=day%7;
        sum[day]++;//3.13        
        day=day+3;
        day=day%7;
        sum[day]++;//4.13 
        day=day+2;
        day=day%7;
        sum[day]++;//5.13  
        day=day+3;
        day=day%7;
        sum[day]++;//6.13 
        day=day+2;
        day=day%7;
        sum[day]++;//7.13
        day=day+3;
        day=day%7;
        sum[day]++;//8.13 
        day=day+3;
        day=day%7;
        sum[day]++;//9.13 
        day=day+2;
        day=day%7;
        sum[day]++;//10.13 
        day=day+3;
        day=day%7;
        sum[day]++;//11.13 
        day=day+2;
        day=day%7;
        sum[day]++;//12.13 
        day=day+3;                                    
        day=day%7;
    }
    fprintf(out,"%d %d %d %d %d %d %d\n",sum[6],sum[0],sum[1],sum[2],sum[3],sum[4],sum[5]);
    fclose(in);
    fclose(out);
    return 0;
}

```

