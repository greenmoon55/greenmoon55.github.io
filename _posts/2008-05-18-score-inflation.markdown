---
author: admin
comments: true
date: 2008-05-18 09:39:50+00:00
layout: post
slug: score-inflation
title: Score Inflation
wordpress_id: 44
categories:
- Programming
tags:
- DP
- USACO
---

翻译：[http://www.nocow.cn/index.php/Translate:USACO/inflate](http://www.nocow.cn/index.php/Translate:USACO/inflate)

第一个递归会超时，第二个是背包：f[n,m]=max{f[n-1,m]+f[n,m-t[n]]+s[n]}

<!-- more -->



> 
USER: Jin Dong [djgreen1]
TASK: inflate
LANG: PASCAL

Compiling...
Compile: OK

Executing...
   Test 1: TEST OK [0.000 secs, 276 KB]
   Test 2: TEST OK [0.000 secs, 280 KB]
   Test 3: TEST OK [0.011 secs, 280 KB]

  > Run 4: Execution error: Your program (`inflate') used more than
        the allotted runtime of 1 seconds (it ended or was stopped at
        2.700 seconds) when presented with test case 4. It used 280 KB of
        memory.


    Test 4: RUNTIME 2.700>1 (280 KB)





```pascal 

{
ID: djgreen1
PROG: inflate
LANG: PASCAL
}
program inflatev1;
var
        m, n: longint;
        score, time: array[0..10000] of longint;
        max: longint;
        i: longint;
procedure work(s, t, p: longint);
var
        i: longint;
begin
        if t &amp;amp;amp;amp;gt; m then exit;
        if s &amp;amp;amp;amp;gt; max then max := s;
        if p &amp;amp;amp;amp;gt; n then exit;
        for i := 0 to m div time[p] do work(s + score[p] * i, t + time[p] * i, p + 1);
end;
begin
        assign(input, 'inflate.in');
        assign(output, 'inflate.out');
        reset(input);
        rewrite(output);
        readln(m, n);
        max := 0;
        for i := 1 to n do readln(score[i], time[i]);
        work(0, 0, 1);
        writeln(max);
        close(input);
        close(output);
end.

```




> 
USER: Jin Dong [djgreen1]
TASK: inflate
LANG: PASCAL

Compiling...
Compile: OK

Executing...
   Test 1: TEST OK [0.000 secs, 320 KB]
   Test 2: TEST OK [0.000 secs, 320 KB]
   Test 3: TEST OK [0.000 secs, 324 KB]
   Test 4: TEST OK [0.000 secs, 324 KB]
   Test 5: TEST OK [0.011 secs, 324 KB]
   Test 6: TEST OK [0.032 secs, 324 KB]
   Test 7: TEST OK [0.130 secs, 320 KB]
   Test 8: TEST OK [0.346 secs, 320 KB]
   Test 9: TEST OK [0.583 secs, 324 KB]
   Test 10: TEST OK [0.605 secs, 320 KB]
   Test 11: TEST OK [0.000 secs, 324 KB]
   Test 12: TEST OK [0.000 secs, 324 KB]

All tests OK.
Your program ('inflate') produced all correct answers!  This is your
submission #3 for this problem.  Congratulations!





```pascal 

{
ID: djgreen1
PROG: inflate
LANG: PASCAL
}
program inflatev2;
var
        m, n: longint;
        score, time: array[0..10000] of longint;
        max: longint;
        i, j: longint;
        ans: array[0..10000] of longint;
begin
        assign(input, 'inflate.in');
        assign(output, 'inflate.out');
        reset(input);
        rewrite(output);
        readln(m, n);
        max := 0;
        for i := 1 to n do readln(score[i], time[i]);
        for i := 1 to n do
        begin
                for j := time[i] to m do
                begin
                        if ans[j] &amp;amp;amp;amp;lt; ans[j - time[i]] + score[i] then ans[j] := ans[j -
time[i]] + score[i];
                end;
        end;
        writeln(ans[m]);
        close(input);
        close(output);
end.

```

