---
author: admin
comments: true
date: 2008-04-30 15:29:22+00:00
layout: post
slug: money-systems
title: Money Systems
wordpress_id: 38
categories:
- Programming
tags:
- DP
- USACO
---

翻译：[http://www.nocow.cn/index.php/Translate:USACO/money](http://www.nocow.cn/index.php/Translate:USACO/money)

题意很好理解，与背包类似。N种构成金额为M，则状态转移方程为f[n,m]=f[n-1,m]+f[**n**,m-value[n]]。若转化为数组则每个值只需要上方的和左侧某个值（不一定取得到，m-value[n]>=0），所以可以从左到右处理一维数组。由于数据比较大，还需使用**INT64**。详见程序。

<!-- more -->
My Program:

```pascal 

{
ID: djgreen1
PROG: money
LANG: PASCAL
}
program money;
var
        n, m: longint;
        ans: array[0..10000] of int64;
        value: array[0..25] of longint;
        i, j: longint;
begin
        assign(input, 'money.in');
        assign(output, 'money.out');
        reset(input);
        rewrite(output);
        readln(n, m);
        for i := 1 to n do read(value[i]);
        readln;
        ans[0] := 1;
        for i := 1 to n do
                for j := 1 to m do
                begin
                        if j - value[i]>= 0 then ans[j] := ans[j] + ans[j - value[i]];
                end;
        writeln(ans[m]);
        close(input);
        close(output);
end.

```






> USER: *** [djgreen1]
TASK: money
LANG: PASCAL

Compiling...
Compile: OK

Executing...
   Test 1: TEST OK [0.000 secs, 276 KB]
   Test 2: TEST OK [0.000 secs, 276 KB]
   Test 3: TEST OK [0.000 secs, 276 KB]
   Test 4: TEST OK [0.000 secs, 276 KB]
   Test 5: TEST OK [0.000 secs, 276 KB]
   Test 6: TEST OK [0.011 secs, 276 KB]
   Test 7: TEST OK [0.000 secs, 276 KB]
   Test 8: TEST OK [0.011 secs, 276 KB]
   Test 9: TEST OK [0.000 secs, 276 KB]
   Test 10: TEST OK [0.011 secs, 276 KB]
   Test 11: TEST OK [0.000 secs, 276 KB]
   Test 12: TEST OK [0.000 secs, 280 KB]
   Test 13: TEST OK [0.000 secs, 280 KB]

All tests OK.
YOUR PROGRAM ('money') WORKED FIRST TIME!  That's fantastic
-- and a rare thing.  Please accept these special automated
congratulations.

Here are the test data inputs:

------- test 1 -------
1 1
1
------- test 2 -------
3 10
1 2 5
------- test 3 -------
10 100
1 2 3 4 5 6 7 8 9 10
------- test 4 -------
25 1000
25000
25000
25000
25000
25000
25000
25000
25000
25000
25000
25000
25000
25000
25000
25000
25000
25000
25000
25000
25000
25000
25000
25000
25000
25
------- test 5 -------
25 9999
25000
25000
25000
25000
25000
25000
25000
25000
25000
25000
25000
25000
25000
25000
25000
25000
25000
25000
25000
25000
25000
25000
25000
25000
26
------- test 6 -------
25 9999
346
130
982
1090
1656
7117
7595
6415
2948
1126
9004
4558
3571
2879
8492
1360
5412
6721
2463
5047
7119
1441
7190
3985
1214
------- test 7 -------
25 999
7843
4639
1653
3876
5457
2152
2524
2412
7461
3564
4634
7717
5947
4056
1048
6123
1757
5964
1137
3094
671
5869
2719
631
3563
------- test 8 -------
25 100
25
24
23
22
21
20
19
18
17
16
15
14
13
12
11
10
9
8
7
6
5
4
3
2
1
------- test 9 -------
25 100
37
36
35
34
33
32
31
30
29
28
27
26
25
24
23
22
21
20
19
18
17
16
15
14
13
------- test 10 -------
5 10000
5 8 13 21 34
------- test 11 -------
17 500
11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27
------- test 12 -------
8 10000
1 2 3 4 5 6 20 25
------- test 13 -------
17 2000
11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27

Keep up the good work!


Thanks for your submission!
