---
author: admin
comments: true
date: 2013-07-13 02:35:58+00:00
layout: post
slug: codeforces-round-191-div-2
title: 'Codeforces Round #191 (Div. 2)'
wordpress_id: 446
categories:
- Programming
---

比赛是在嘉定做的，只做了A，rating掉到历史新低= =


# A. Flipping Game


n个0或1，从中任选i,j，翻转从i到j的数（变成x-1），求最长连续的1。由于n很小（100），直接模拟即可。


# B. Hungry Sequence


输出一个递增的序列，要求任意一项不能被其他项整除。序列长度最大为10^5，每个数字不能超过10^7。

如果全部输出质数就是符合条件的，比赛的时候脑残以为质数不够，所以乱搞的，现在看来貌似不太对。。


# C. Magic Five


给出一个数字，可以去掉任意个digit，不能全部去掉，可以有leading zero，问能有多少种情况使处理后的数字能被5整除。

这个思路很明显，就是找5和0，然后乘以2^i，i为前面的位数。但是实现上有一些问题。

\(ans = 2^i + 2^{l+i} + 2^{2l+i} + ... + 2^{(k-1)l+i}\)

\(ans = 2^i * (1 + 2^{l} + 2^{2l} + ... + 2^{(k-1)l})\)

\(1 + 2^{l} + 2^{2l} + ... + 2^{(k-1)l} = \frac{2^{k*l}-1}{2^l-1} \)

现在的重点就是求出\(\frac{2^{k*l}-1}{2^l-1} \)

可以根据费马小定理什么的把\(\frac{a}{b} \mod{p}\)转换成\(a* b^{p-2} \mod {p}\)
但是这里有些问题，我还不太理解证明的过程，比如说费马小定理要求b与p互质，这里没法证吧= =


```cpp 

#include 
#include 
using namespace std;
const int MAXA = 100005;
const int MOD = 1000000007;
int pow(long long a, long long b, long long mod = MOD)
{
  //cout << a << " ^ " << b << " = ";
  long long ans = 1;
  while (b)
  {
    if (b & 1) ans = (ans * a) % mod;
    b >>= 1;
    a = (a * a) % mod;
  }
  //cout << ans << endl;
  return ans;
}
int main()
{
  string str;
  int k;
  cin >> str >> k;
  int l = str.length();
  long long ans = 0;
  for (int i = 0; i < l; i++)
  {
    if (str[i] == '5' || str[i] == '0')
    {
      ans = (ans + pow(2, i)) % MOD;
    }
  }
  ans = ans * (pow((pow(2, k) % MOD), l) % MOD - 1 + MOD) % MOD * pow((pow(2, l) - 1), MOD - 2) % MOD;
  cout << ans << endl;
  return 0;
}

```



# D. Block Tower


对于每个联通块，可以先全部涂成蓝色，然后只保留一个为蓝色（我选的是第一个），其他都换成红色。
刚开始我用了BFS，而且还用了deque、struct Point，结果segmentation fault = =

```cpp 

#include 
#include 
#include 
#include 
using namespace std;
const int MAXN = 505;
char map[MAXN][MAXN];
int n, m;
struct Operation
{
  int x, y;
  char operation;
};
queue ansq;
void ans(int x, int y, char operation)
{
  Operation op;
  op.x = x;
  op.y = y;
  op.operation = operation;
  ansq.push(op);
}
int firsti, firstj;
void search(int x, int y)
{
  map[x][y] = 'T';
  ans(x, y, 'B');
  if (x - 1 >= 0 && map[x-1][y] == '.')
    search(x-1, y);
  if (x + 1 < n && map[x+1][y] == '.')
    search(x+1, y);
  if (y - 1 >= 0 && map[x][y-1] == '.')
    search(x, y-1);
  if (y + 1 < m && map[x][y+1] == '.')
    search(x, y+1);
  if (x == firsti && y == firstj) return;
  ans(x, y, 'D');
  ans(x, y, 'R');
}
int main()
{
  scanf("%d%d", &n;, &m;);
  gets(map[0]);
  for (int i = 0; i < n; i++)
  {
    gets(map[i]);
  }
  for (int i = 0; i < n; i++)
  {
    for (int j = 0; j < m; j++)
    {
      if (map[i][j] == '.')
      {
        firsti = i;
        firstj = j;
        search(i,j);
      }
    }
  }
  printf("%d\n", ansq.size());
  while (!ansq.empty())
  {
    Operation op = ansq.front();
    printf("%c %d %d\n", op.operation, op.x + 1, op.y + 1);
    ansq.pop();
  }
  return 0;
}

```

