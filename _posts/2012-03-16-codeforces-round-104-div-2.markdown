---
author: admin
comments: true
date: 2012-03-16 12:54:02+00:00
layout: post
slug: codeforces-round-104-div-2
title: 'Codeforces Round #104 (Div. 2) '
wordpress_id: 346
categories:
- Programming
---

[Codeforces Round #104 (Div. 2) ](http://codeforces.com/contest/146)
[Editorial](http://codeforces.com/blog/entry/3746)

比赛时做出三题

A略 B忘了题意，也略吧...

**C Lucky Conversion**
只需记录两字符串相应位置分别出现47和74的次数，输出这两个数的最大值

**D Lucky Number 2**
这个看了题解
想象删除所有相邻重复数字，可以得到形如47474747474747的串，所以 a3 与 a4 的差的绝对值一定小于等于1。然后分三种情况讨论：



	
  1. a3 = a4，若 a1 = a3，则说明4不够多，生成的串以7开头，如74747，多余的7插入到最右面，多余的4放在最左边的4。。否则形如47474，多余的7插入到最右面的7，多余的4放在最左边。


	
  2. a3 > a4，形如47474747，多余的4放在最前面，7放在最后面


	
  3. a3 < a4，形如74747474，多余的4插入到1位置，7插入到最后面的7



```cpp 

#include 
#include 
#include 
#include 
using namespace std;
int main()
{
    int a1, a2, a3, a4;
    cin >> a1 >> a2 >> a3 >> a4;
    if (abs(a3 - a4) > 1)
    {
        puts("-1");
        return 0;
    }
    string str;
    if (a3 == a4)
    {
        if ((a1 == a3 && a2 == a3) ||
        a1 < a3 || a2 < a3)
        {
            puts("-1");
            return 0;
        }
        // '4' is not enough
        if (a1 == a3)
        {
            for (int i = 0; i < a3; i++) str += "74";
            str += "7";
            if (a2 > a3 + 1)
            {
                string temp(a2 - a3 - 1, '7');
                str.append(temp);
            }
        }
        else // '4' is enough
        {
            for (int i = 0; i < a3; i++) str += "47";
            str += "4";
            if (a1 > a3 + 1)
            {
                /*
                string ( size_t n, char c );
                Content is initialized as a string formed
                by a repetition of character c, n times.
                */
                string temp(a1 - a3 - 1, '4');
                str.insert(0, temp);
            }
            if (a2 > a3)
            {
                string temp(a2 - a3, '7');
                str.insert(str.find_last_of('7'), temp);
            }
        }
    }
    else if (a3 < a4)
    {
        for (int i = 0; i < a4; i++) str += "74";
        if (a1 < a4 || a2 < a4)
        {
            puts("-1");
            return 0;
        }
        if (a1 > a4)
        {
            string temp(a1 - a4, '4');
            str.insert(1, temp);
        }
        if (a2 > a4)
        {
            string temp(a2 - a4, '7');
            str.insert(str.find_last_of('7'), temp);
        }
    }
    else // a3 > a4
    {
        for (int i = 0; i < a3; i++) str += "47";
        if (a1 < a3 || a2 < a3)
        {
            puts("-1");
            return 0;
        }
        if (a1 > a3)
        {
            string temp(a1 - a3, '4');
            str.insert(0, temp);
        }
        if (a2 > a3)
        {
            string temp(a2 - a3, '7');
            str.insert(str.find_last_of('7'), temp);
        }
    }
    cout << str << endl;
    return 0;
}


```

