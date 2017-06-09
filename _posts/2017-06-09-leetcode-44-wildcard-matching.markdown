---
layout: post
title: LeetCode 44 Wildcard Matching
published: false
---

```python
class Solution(object):
    def isMatch(self, s, p):
        """
        :type s: str
        :type p: str
        :rtype: bool
        """
        if len(s) == 0:
            for ch in p:
                if ch != '*':
                    return False
            return True
        f = [[False] * (len(p)+1) for x in xrange(len(s)+1)]
        f[0][0] = True
        for i in xrange(0, len(s) + 1):
            for j in xrange(1, len(p) + 1):
                if p[j-1] == s[i-1] or p[j-1] == '?':
                    f[i][j] = f[i-1][j-1]
                elif p[j-1] == '*':
                    for k in xrange(0, i+1):
                        if f[k][j-1]:
                            f[i][j] = True
                            break
        #print f
        return f[len(s)][len(p)]
```

第一个思路是f[i][j]表示s[i]匹配到p[j]能否实现，两重循环计算，遇到*还要再加一层循环来确定p前一位匹配到了哪里。提交之后TLE。

可以发现有两个可以优化的地方，第一个是f[i][j]第二维只需要j-1，因此可以降成一维数组。第二个是当p[j]是*时，任意f[k][j](k<=i)为True都可以，不需要每个i都向前搜索一遍，而应该遇到f[k][j]反过来填后面的发f[i][j](i>=k)。

```python
class Solution(object):
    def isMatch(self, s, p):
        """
        :type s: str
        :type p: str
        :rtype: bool
        """
        if len(s) == 0:
            for ch in p:
                if ch != '*':
                    return False
            return True
        f = [False] * (len(s)+1)
        f[0] = True
        for ch in p:
            if ch != '*':
                for i in xrange(len(s), 0, -1):
                    if s[i-1] == ch or ch == '?':
                        f[i] = f[i-1]
                    else:
                        f[i] = False
                f[0] = False
            else:
                for i in xrange(len(s)):
                    if f[i]:
                        for j in xrange(i+1, len(s) + 1):
                            f[j] = True
                        break
        return f[len(s)]
```
此时f[i]表示截止到当前ch，能否匹配到第i位。
