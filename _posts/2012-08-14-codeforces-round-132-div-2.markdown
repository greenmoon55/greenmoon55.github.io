---
author: admin
comments: true
date: 2012-08-14 02:34:36+00:00
layout: post
slug: codeforces-round-132-div-2
title: 'Codeforces Round #132 (Div. 2)'
wordpress_id: 390
categories:
- Programming
---

**A. Bicycle Chain**
略

**B. Olympic Medal**
可以很容易地推出公式，有些变量直接用double了，用int相乘会溢出。

```cpp 

#include 
#include 
#include 
#include 
using namespace std;
const int MAXN = 5010;
double x[MAXN], y[MAXN], z[MAXN];
int main()
{
    int n, m, k;
    double a, b;
    cin >> n;
    for (int i = 0; i < n; i++) cin >> x[i];
    cin >> m;
    for (int i = 0; i < m; i++) cin >> y[i];
    cin >> k;
    for (int i = 0; i < k; i++) cin >> z[i];
    cin >> a >> b;

    sort(x, x + n);
    sort(z, z + k);
    double r1 = x[n - 1];
    double p2 = z[0];
    double ans = 0;
    for (int i = 0; i < m; i++)
    {
        double temp = sqrt(b * y[i] * r1 * r1 / (a * p2 + b * y[i]));
        if (temp >= r1) continue;
        ans = max(ans, temp);
    }
    printf("%.10lf\n", ans);
    return 0;
} 

```


**C. Crosses**
这题折腾死我了。。Virtual paticipation的时候我猜是个DP，完全没思路。看了题解才知道，是枚举包含Cross的最小矩形，然后算一下四角需要去掉多大面积，枚举某方向的边长，到sqrt(area)即可，全部枚举会超时。如果是矩形，a,b和c,d可以交换位置，所以算两种情况。这里要注意一下。。我有点晕，WA好多次。

```cpp 

#include 
#include 
#include 
using namespace std;

int main()
{
    int n, m, s;
    cin >> n >> m >> s;
    long long ans = 0;
    for (int i = 1; i <= n; i += 2)
    {
        for (int j = 1; j <= m; j += 2)
        {
            if (i * j < s) continue;
            long long v = (n - i + 1) * (m - j + 1);
            if (i * j == s)
            {
                v *= 2 * (i / 2 + 1) * (j / 2 + 1) - 1;
            }
            else
            {
                int area = i * j - s;
                if (area % 4 != 0) continue;
                area /= 4;
                int temp = 0;
                int length = sqrt(area);
                for (int k = 1; k <= length; k++)
                {
                    if (area % k != 0) continue;
                    if (k * 2 < i && area / k * 2 < j) temp++;
                    if (k * 2 < j && area / k * 2 < i) temp++;
                }
                if (length * length == area)
                    if (length * 2 < i && length * 2 < j) temp--;
                v *= temp * 2;
            }
            ans += v;
        }
    }
    cout << ans << endl;
    return 0;
}

```



**D. Hot Days**
这题的题目描述好复杂，当时看了好久才懂。第一反应是三分法，后来一想，只有两种可能嘛，一种是有足够多的车，没有“罚款”，另外一种是只有一辆车，可能有罚款。如果车的数量不够多，罚的钱和只有一辆车是一样的。注意一定会罚款的情况，因为这个WA一次= =

```cpp 

#include 
#include 
#include 
using namespace std;
int main()
{
    long long n, m;
    long long t, T, x, cost;
    long long ans = 0;
    cin >> n >> m;
    while (n--)
    {
        cin >> t >> T >> x >> cost;
        if (T <= t)
        {
            ans += cost + m * x;
            continue;
        }
        long long count = ceil(m / (double)(T - t));
        long long t1 = count * cost;
        long long t2 = cost + m * x;
        ans += min(t1, t2);
    }
    cout << ans << endl;
    return 0;
}

```

