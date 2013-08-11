---
author: admin
comments: true
date: 2012-05-12 04:12:33+00:00
layout: post
slug: google-code-jam-2012
title: Google Code Jam 2012
wordpress_id: 366
categories:
- Programming
tags:
- CodeJam
---

**Qualification Round**
Problem A. Speaking in Tongues
简单的按规律替换字符串
Problem B. Dancing With the Googlers
忘记了具体内容了，反正要注意边界特殊情况。
Problem C. Recycled Numbers
比赛时想不明白 Case #4，于是没交大数据，后来看了 Contest Analysis 才知道有1212这种情况，会重复。比赛的时候移位是用字符串实现的。。后来才改过来。看了代码 Contest Analysis 的才知道不用数组记录数字是否出现的，**只要移回原数就退出**，即可避免循环节的问题。

```cpp 

#include 
#include 
using namespace std;

int a, b;
long long ans;

void work(int num)
{
    int temp = num;
    int base = 1;
    int digit = 1;
    while (temp / 10 > 0)
    {
        base *= 10;
        temp /= 10;
        ++digit;
    }
    int move;
    int a[10];
    temp = num;
    for (int i = 0; i < digit - 1; i++)
    {
        move = temp % 10;
        temp /= 10;
        temp += base * move;
        a[i] = temp;
        if (temp > num && temp <= b)
        {
            ans++;
            // 判断 temp 是否出现过
            for (int j = 0; j < i; j++)
                if (a[i] == a[j])
                {
                    --ans;
                    break;
                }
        }

    }
}

int main()
{
    int t;
    cin >> t;
    for (int tcase = 1; tcase <= t; tcase++)
    {
        scanf("%d%d", &a;, &b;);
        ans = 0;
        for (int i = a; i < b; i++)
        {
            work(i);
        }
        printf("Case #%d: ", tcase);
        cout << ans << endl;
    }
    return 0;
}

```


**Round 1B**
Problem A. Safety in Numbers
这道题非常好玩。题意是这样的：每位选手的得分 = 评委给分 + 所有选手得到的评委给分和 * 这位选手的观众投票率(0-100%)。每个观众只能投一个选手，现在要淘汰得分最低的选手，若有多位选手得分相同，且都为最低分数，那么没人会被淘汰。求每位选手至少需要得到多少观众投票才能不被淘汰。

第一个想法就是先不考虑观众投票，对于当前选手A，找现在得分最低的选手B，算一下A要多少投票率才能超过剩下的票都投B的得分。这个想法是错误的。因为算完之后，其他多个选手可能比A、B得分都少，只需要让A的得分大于等于所有人都最低分数即可。

看看 Case #4，


> 
Input: 3 24 30 21
Output: 34.666667 26.666667 38.666667



每个人的得分是相同的！这是一个巧合吗？不是的，由于评委给分已知，每个观众只能投一票，所有选手的得分总和是固定的，那么每个选手只要得到 所有选手的得分总和 / 选手个数 即可保证不被淘汰。那么，先求出平均得分，然后对每个选手解方程求投票率即可。

小数据里有这样一种情况。


> 8 0 0 0 0 72 0 0 0


每位选手的平均得分是(72 + 72) / 8 = 18，显然72已经远远超过18了。那么此时就不考虑72（也就是说72不需要观众投票），平均得分为(0 + 72) /7 = 10.2857143，然后投票率为 (10.2857143 - 0) / 72 = 14.2857143%。

这样就可以过小数据了，不过还有一个问题，如果去掉72之后，仍然有数字大于平均得分怎么办？
先从大到小排个序，然后依次考虑即可，大于平均得分就说明这位选手不需要投票，答案为 0。最后的就肯定需要投票啦，不管他的评委得分是多少，如果得到100%的观众投票就肯定不会被淘汰，如：


> 2 10 0



```cpp 

#include 
#include 
#include 
#include 
using namespace std;

int num[250],num2[250];
int main()
{
    int t;
    int n;
    cin >> t;
    for (int tcase = 1; tcase <= t; tcase++)
    {
        cin >> n;
        int sum = 0;
        for (int i = 0; i < n; i++)
        {
            cin >> num[i];
            sum += num[i];
        }
        memcpy(num2, num, sizeof(num2));
        sort(num, num+n, greater());
        double temp = (sum * 2) / (double)n;
        int count = n;
        int total = sum;
        for (int i = 0; i < n; i++)
        {
            if (temp < num[i])
            {
                total-=num[i];
                --count;
                temp = (total + sum) / (double)count;
            }
        }
        printf("Case #%d: ", tcase);
        if (num2[0] > temp) printf("0");
        else printf("%lf", (temp - num2[0]) / sum * 100);
        for (int i = 1; i < n; i++)
        {
            if (num2[i] > temp) printf(" 0");
            else printf(" %lf", (temp - num2[i]) / sum * 100);
        }
        cout << endl;
    }
    return 0;
}

```


**Round 1C**
Problem A. Diamond Inheritance
判断是否有这种情况发生：D类继承自B类和C类，B类继承自A类，C类也继承自A类，这就形成了一个菱形。
我用并查集做的...DFS，如果结点被访问时已经和上一个结点在同一个集合里就说明出现了这种情况。
呃，似乎用不到并查集啊，用个bool used[]标记就行了吧。。
虽然共有1000个类，但每个类最多继承自10个类。

```cpp 

#include 
#include 
#include 
using namespace std;
const int nodeMax = 1010;
int p[nodeMax];//p:parent
int rank[nodeMax];
int map[nodeMax][nodeMax];
int n;

void make_set()
{
    for (int i=1;i<=n;i++) //pay attention!
    {
        p[i]=i;
        rank[i]=0;
    }
}

int find_set(int x)
{
    if (x!=p[x]) p[x]=find_set(p[x]);
    return p[x];
}

bool work(int a)
{
    int x, y;
    int temp;
    for (int i = 1; i <=map[a][0]; i++)
    {
        temp = map[a][i];
        x = find_set(a);
        y = find_set(map[a][i]);
        if (x != y)
        {
            if (rank[x]>rank[y]) p[y]=x;
            else
            {
                p[x]=y;
                if (rank[x]==rank[y]) rank[y]++;
            }
        }
        else return true;
    }
    for (int i = 1; i <= map[a][0]; i++)
    {
        if (work(map[a][i])) return true;
    }
    return false;
}

int main()
{
    int t;

    cin >> t;
    for (int tcase = 1; tcase <= t; tcase++)
    {
        cin >> n;
        for (int i = 1; i <= n; i++)
        {
            cin >> map[i][0];
            for (int j  = 1; j <= map[i][0]; j++) cin >> map[i][j];
        }
        bool yes = false;
        for (int i = 1; i <= n; i++)
        {
            make_set();
            if (work(i))
            {
                yes = true;
                break;
            }
        }
        printf("Case #%d: ", tcase);
        if (yes) printf("Yes\n");
         else printf("No\n");
    }
    return 0;
}

```

Problem B. Out of Gas
这完全是个物理题，读题很费时间。
你开一辆车，给定最大加速度，减速的加速度随意，也就是说可以瞬间停车。前面有一辆车一直匀速运动，不过它的速度在特定的点可以突然改变。求从起始点到指定位置的最短时间。
Small Input 最多只有两个点，比一下前面的车还是自己的车一直加速先到指定位置即可。刚花了一晚上写大数据，越写越烦，一看才73人A了这个。。还是算了吧。。

```cpp 

#include 
#include 
#include 
#include 
using namespace std;

struct point
{
    double t;
    double x;
}p[5];
double acc[15];
int main()
{
    int t;
    double d;
    int n, a;
    cin >> t;
    for (int tcase = 1; tcase <=t; tcase++)
    {
        printf("Case #%d:\n", tcase);
        cin >> d >> n >> a;
        for (int i = 0; i < n; i++)
        scanf("%lf%lf", &p;[i].t, &p;[i].x);
        for (int i = 0; i < a; i++)
        scanf("%lf", &acc;[i]);
        double t1, t2;
        if (n == 2)
        {
            t2 = p[0].t + (d - p[0].x) * (p[1].t - p[0].t) / (p[1].x - p[0].x);
            for (int i = 0; i < a; i++)
            {
                t1 = sqrt(2*d/acc[i]);
                if (t1 > t2) printf("%.7lf\n", t1);
                else printf("%.7lf\n", t2);
            }
        }
        else
        {
            for (int i = 0; i < a; i++)
            {
                t1 = sqrt(2*d/acc[i]);
                printf("%.7lf\n", t1);
            }
        }
    }
    return 0;
}

```


Code Jam 还是挺好玩的，而且比赛结束之后马上出排名。最后1015没进，明年再来吧。
还想看看 Round 1C 的 Problem C. Box Factory 和 Round 1B 的 Problem C. Equal Sums。
