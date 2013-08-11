---
author: admin
comments: true
date: 2012-03-11 05:32:25+00:00
layout: post
slug: codeforces-round-111-div-2
title: 'Codeforces Round #111 (Div. 2)'
wordpress_id: 344
categories:
- Programming
tags:
- Codeforces
---

[Codeforces Round #111 (Div. 2)](http://codeforces.com/contest/160)

AB略
[C](http://codeforces.com/contest/160/problem/C)
看起来挺简单的一道题，看样例显然就是输出a[k/n]和a[k%n]，于是WA了两遍...
其实这样是不对的，比如：


> 
1 1 2
11
11
11
11
12
12
21
21
22
1 2 2 2 3
11
12
12
12
13
21
21
21
22
22
22
22
22
22
22
22
22
23
23
23
31
32
32
32
33



test3就是这种数据...
其实应该是a[k/n] a[(k - 重复数字区开始位置(21处))/重复数字个数]，还要注意long long...


```cpp 

#include 
#include 
#include 
#include 
using namespace std;

int main()
{
    long long n;
    long long k;
    int a[100005];
    long long b[100005]; //重复段开始数字位置
    long long c[100005]; //重复数字个数，存在开始位置

    memset(b, 0, sizeof(b));
    memset(c, 0, sizeof(c));

    cin >> n >> k;
    for (int i = 0; i < n; i++) cin >> a[i];

    sort(a, a + n);
    b[0] = 0;
    for (int i = 1; i < n; i++)
    {
        if (a[i] == a[i-1]) b[i] = b[i-1];
        else //重复段结束时处理
        {
            b[i] = i;
            c[b[i-1]] = i - b[i-1];
        }
    }
    c[b[n-1]] = n - b[n-1]; //处理最后的数字
    --k;

    long long start = b[k/n] * n;
    long long count = c[b[k/n]];
    cout << a[k/n] << " " << a[(k - start) / count] << endl;
    //cout << a[k/n] << " " << a[k%n] << endl; 错误做法

    return 0;
}

```


DE还没做，看起来D是个好题。
