---
author: admin
comments: true
date: 2012-03-08 10:03:23+00:00
layout: post
slug: codeforces-beta-round-97-div-2
title: 'Codeforces Beta Round #97 (Div. 2)'
wordpress_id: 342
categories:
- Programming
---

[Codeforces Beta Round #97 (Div. 2)](http://codeforces.com/contest/136)

AB略，现在都忘了是啥题了。。

C
选择数组中的一个数，并把它改为另一个值（和原值不同），排序后求数组所有位置的最小可能值。
显然就是把最大的数改成1。注意特殊情况：数组里所有的数都是1。
当时把10^5的数组开成10^4了。。

D
判断给出的8个点能否构成一个矩形和一个正方形。
用next_permutation搞出排列，用两个向量数量积是否为零判断垂直，四个角都是直角，说明是矩形，四条边长度相等就是菱形，既是矩形又是菱形就是正方形。。

```cpp 

#include 
#include 
#include 
using namespace std;
const double eps = 1e-9;
struct TPoint
{
    int x, y;
}point[10];
int index[] = {0, 1, 2, 3, 4, 5, 6, 7};

inline int sgn(double x)
{
    return x>eps?1:x<-eps?-1:0;
}

//点积
int dot(const TPoint &a;, const TPoint &b;, const TPoint &c;)
{
    return (a.x - b.x) * (c.x - b.x) + (a.y - b.y) * (c.y - b.y);
}

//ab是否与cb垂直（b为交点）
bool isPerpendicular(const TPoint &a;, const TPoint &b;, const TPoint &c;)
{
    return !dot(a, b, c);
}

bool isRect(const TPoint &a;, const TPoint &b;, const TPoint &c;, const TPoint &d;)
{
    return isPerpendicular(a, b, c) && isPerpendicular(b, c, d) && isPerpendicular(c, d, a)
        && isPerpendicular(d, a, b);
}

inline int dis(const TPoint &a;, const TPoint &b;)
{
    return (a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y);
}
bool isRhombus(const TPoint &a;, const TPoint &b;, const TPoint &c;, const TPoint &d;)
{
    return (dis(a, b) == dis(b, c)) && (dis(b, c) == dis(c, d)) && (dis(c, d) == dis(d, a));
}

bool isSquare(const TPoint &a;, const TPoint &b;, const TPoint &c;, const TPoint &d;)
{
    return isRect(a, b, c, d) && isRhombus(a, b, c, d);
}


int main()
{
    for (int i = 0; i < 8; i++) cin >> point[i].x >> point[i].y;
    do
    {
        if (isSquare(point[index[0]], point[index[1]], point[index[2]], point[index[3]]) &&
            isRect(point[index[4]], point[index[5]], point[index[6]], point[index[7]]))
        {
            printf("YES\n");
            for (int j = 0; j < 8; j++) index[j]++;
            printf("%d %d %d %d\n", index[0], index[1], index[2], index[3]);
            printf("%d %d %d %d\n", index[4], index[5], index[6], index[7]);
            return 0;
        }
    } while (next_permutation(index, index + 8));
    printf("NO\n");
    return 0;
}

```


E
这个题很不错。
输入数据由'0', '1', '?'组成。'?'可能是'0'或'1'。两人轮流取数字，直到最后只剩两个数字，先取的人希望最后剩下的数字最小，后取的人希望剩下的数字最大。
以下基本是[官方题解](http://codeforces.ru/blog/entry/3353?locale=en)的翻译...

先取的人显然会取最左面的1，后取的人显然会取最右面的0。
首先考虑没有问号的情况，设1有a个，0有b个，若a>=b+2，结果就是11；若a<=b-1，结果就是00。若a=b+1或a=b，结果可能是01或10，那么到底是哪种呢？因为每次都从左取0和1，而且最后剩下的两个数字里0和1都有，所以肯定没取到最右边的数字。那么如果最后一位是1，结果就是01，最后一位是0，结果就是10。

接下来考虑有问号的情况，设问号有c个。首先判断能不能出现00和11。判断a+c>=b+2和a<=b-1+c即可。然后考虑01和10，若最后一位不是问号，设问号中有x个是1，则c-x个是0。根据a+x=b+(c-x)+(a+b+c)%2，也就是以前的a=b+1或a=b，解出x的值，x必须大于等于零并小于等于c，根据最后一位的数字就能判断是否可能出现01和10。如果最后一位是问号，可以把它看成是0和1分别考虑，即--c后++a或++b，然后再判断x是否合法。

```cpp 

#include 
#include 
#include 
using namespace std;

int main()
{
    char ch[100005];
    int a = 0; // 1 count
    int b = 0; // 0 count
    int c = 0; // ? count
    int x = 0;
    int length;

    scanf("%s", ch);
    length = strlen(ch);

    for (int i = 0; i < length; i++)
    {
        switch (ch[i])
        {
            case '1':
                ++a;
                break;
            case '0':
                ++b;
                break;
            case '?':
                ++c;
                break;
        }
    }

    if (!c)
    {
        if (a < b) puts("00");
        if (a == b || a == b + 1)
        {
            if (ch[length - 1] == '1') puts("01");
            if (ch[length - 1] == '0') puts("10");
        }
        if (a > b + 1) puts("11");
    }
    else
    {
        if (a < b + c) puts("00");

        if (ch[length - 1] == '1')
        {
            x = (b + c - a + (a + b + c) % 2) / 2;
            if (x >= 0 && x <= c) puts("01");
        }
        if (ch[length - 1] == '0')
        {
            x = (b + c - a + (a + b + c) % 2) / 2;
            if (x >= 0 && x <= c) puts("10");
        }
        if (ch[length - 1] == '?')
        {
            --c;
            ++a;

            x = (b + c - a + (a + b + c) % 2) / 2;
            if (x >= 0 && x <= c) puts("01");

            --a;
            ++b;

            x = (b + c - a + (a + b + c) % 2) / 2;
            if (x >= 0 && x <= c) puts("10");

            --b;
            ++c;
        }

        if (a + c > b + 1) puts("11");
    }
    return 0;
}

```

