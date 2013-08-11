---
author: admin
comments: true
date: 2012-02-14 13:30:04+00:00
layout: post
slug: hdu3682-to-be-an-dream-architect
title: HDU3682 To Be an Dream Architect
wordpress_id: 338
categories:
- Programming
tags:
- ACM
---

题意：一个 n x n x n 的立方体，每次消除一行（平行于坐标轴），共消除 m 次，求共消除了多少 1 * 1 * 1 的小块。(1 <= n <= 1000, 0 <= m <= 1000)

第一想法是三维布尔数组数组存状态，然后模拟。不会超时但会MLE。
北大的题解里说了两种方法，第一种是考虑线段的交点，然后用容斥原理，我还没想具体怎么写。第二种是一层一层考虑，把垂直于某层的线和在这个面上的线分开考虑，比较好理解。

经过搜索，搜到了这两个题解：
[http://blog.csdn.net/liuwei_nefu/article/details/6009644](http://blog.csdn.net/liuwei_nefu/article/details/6009644)
[http://www.cnblogs.com/FreeAquar/archive/2011/09/15/2178029.html](http://www.cnblogs.com/FreeAquar/archive/2011/09/15/2178029.html)

做法就是把点坐标映射为int，比如x * 1000000 + y * 1000 + z。然后把所有直线上的点丢到一个vector里，排序后再用[unique](http://www.cplusplus.com/reference/algorithm/unique/)函数，然后[删去](http://www.cplusplus.com/reference/stl/vector/erase/)不需要的部分，求出vector的大小，这就是真正删掉的点。用set做会超时，而且内存占用很多。。
这几个函数只是知道名字，用法一点都不熟悉。


```cpp 

#include 
#include 
#include 
#include 
using namespace std;
inline bool illegal(const int &x;)
{
    return !(x <= 1000 && x > 0);
}
inline int getint(const int &x;, const int &y;, const int &z;)
{
    //cout<> t;
    while(t--)
    {
        vector myvector;
        cin >> n >> m;
        getchar();
        while (m--)
        {
            scanf("%c=%d,%c=%d\n", &ch1;, &a;, &ch2;, &b;);
            if (illegal(a) || illegal(b)) continue;
            a--;
            b--;
            if (ch1 == 'X')
                if (ch2 == 'Y')
                    {
                        for (int i = 0; i < n; i++) myvector.push_back(getint(a, b, i));
                    }
                else //X=a,Z=b
                {

                    for (int i = 0; i < n; i++) myvector.push_back(getint(a, i, b));
                }
            if (ch1 == 'Y')
                if (ch2 == 'X')
                {
                    for (int i = 0; i < n; i++)
                    {
                        myvector.push_back(getint(b, a, i));
                    }
                }
                else //Y=a,Z=b
                {

                    for (int i = 0; i < n; i++)
                    {
                        myvector.push_back(getint(i, a, b));
                    }
                }
            if (ch1 == 'Z')
                if (ch2 == 'X')
                {
                    for (int i = 0; i < n; i++)
                    {
                        myvector.push_back(getint(b, i, a));
                    }
                }
                else
                {
                    for (int i = 0; i < n; i++)
                    {
                        myvector.push_back(getint(i, b, a));
                    }
                }
        }
        sort(myvector.begin(), myvector.end());
        myvector.erase(unique(myvector.begin(), myvector.end()), myvector.end());
        cout << myvector.size() << endl;
    }
    return 0;
}

```

