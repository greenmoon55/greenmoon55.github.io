---
layout: post
title: 'Codeforces Round #418 (Div. 2)'
published: true
---

又是发挥很差的一场，只过了A..

# A. An abandoned sentiment from past

逆序填入数字再判断是否还是递增的序列

# B. An express train to reveries

这道题看了样例想了想就写了个算法，居然还过了pretest，最后WA了。说明要认真想算法的正确性。。

分两种情况讨论：

1. a, b只有一个数字不同，那么说明a[i]和b[i]都不可能是要找的数字，找一找剩下n-1个数中未出现的数字即可。
2. a, b在第i位和第j位不同

如果是
```
1 2 3 4 3
1 2 5 4 5
```
那么i位和j位选哪个都无所谓。

如果是
```
5 4 5 3 1
4 4 2 3 1
```
就要先去掉出现两次的数，例如上面第3位先选b，因为2只出现了一次，接下来第一位选5，因为a中第三位的5已经被替换成2了，5在a中只出现1次。

再举个例子
```
5 4 3 5 2
5 4 1 1 2
```
答案是：
```
5 4 3 1 2
```

```python

# 5
# 5 4 5 3 1
# 4 4 2 3 1

from collections import defaultdict
n = int(input())
a = [int(x) for x in input().split()]
b = [int(x) for x in input().split()]

x = []
a_used = defaultdict(int)
b_used = defaultdict(int)
for i in range(len(a)):
    a_used[a[i]] += 1
    b_used[b[i]] += 1
    if a[i] != b[i]:
        x.append(i)
if len(x) == 2:
    x_done = 0
    while x_done < len(x):
        for i in range(len(x)):
            if a_used[a[x[i]]] > 1 and b_used[b[x[i]]] == 1:
                x_done += 1
                a_used[a[x[i]]] -= 1
                a[x[i]] = b[x[i]]
            elif a_used[a[x[i]]] == 1 and b_used[b[x[i]]] > 1:
                x_done += 1
                b_used[b[x[i]]] -= 1
        if x_done == 0:
            a[x[0]] = b[x[0]]
            break
else:
    for i in range(1, n+1):
        if a_used[i] == 0:
            a[x[0]] = i
            break
print(a[0], end="")
for i in range(1, len(a)):
    print(" " + str(a[i]), end="")
```


# C. An impassioned circulation of affection

当时把自己带到沟里了，想着先split，然后就卡在“aaaaaa”这种情况。今天发现只要暴力扫一遍就好，不需要split啥的。。注意需要先算好所有答案，因为q太大了。
卡python也是无语，只好再用c++写一下。我这里循环用滑动窗口来做，j先确定当前串的长度，另一种做法是直接两重循环串的起点和终点，两种做法都是O(n^2)，没有区别。官方题解还提到了有复杂度更低的算法，目前没有动力去看。。

```cpp
#include <iostream>
#include <string>
using namespace std;
int f[26][1510];

int main() {
    int n, q, m;
    char c;
    string s;
    cin >> n;
    cin >> s;
    for (int i = 0; i < 26; i++) {
        char ch = 'a' + i;
        for (int j = 1; j <= n; j++) {
            int l = 0, r = 0;
            int count = 0;
            while (r < n) {
                if (s[r] != ch) {
                    count++;
                }
                while (count > j) {
                    if (s[l] != ch) {
                        count--;
                    }
                    l++;
                }
                f[i][j] = max(f[i][j], r-l+1);
                r++;
            }
        }
    }
    cin >> q;
    while (q) {
        cin >> m >> c;
        cout << f[int(c-'a')][m] << endl;
        q--;
    }
    return 0;
}
```

