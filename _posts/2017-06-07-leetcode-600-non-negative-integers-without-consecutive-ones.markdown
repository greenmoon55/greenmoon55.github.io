---
layout: post
title: LeetCode 600 Non-negative Integers without Consecutive Ones
published: false
---

第一次ak哈哈，可能是因为这周的比赛比较简单。

先说第一个方法，也是我当时想出来的。分情况讨论，一种是二进制表示的长度小于n的长度，另一种是跟n长度相同。第一种情况任意不含11的数都符合条件，第二种要搜索判断。

```python
class Solution:
    def count(self, i, num, size):
        if i == size - 1:
            return 1
        if num == 1:
            return self.count(i+1, 0, size)
        else:
            return self.count(i+1, 0, size) + self.count(i+1, 1, size)

    # top: whether current value is the same as a
    def countLimit(self, i, num, size, a, top):
        if top and num > a[i]:
            return 0
        if i == size - 1:
            return 1
        if num < a[i]:
            top = False
        if num == 1:
            if top == False:
                # we can choose whatever we want
                return self.all[size-i]
            return self.countLimit(i+1, 0, size, a, top)
        else:
            return self.countLimit(i+1, 0, size, a, top) + self.countLimit(i+1, 1, size, a, top)
            
            
    def findIntegers(self, num):
        """
        :type num: int
        :rtype: int
        """
        # possible solutions starting with 1
        self.all = [0] * 31
        self.all[1] = 1
        self.all[2] = 1
        for i in range(3, 31):
            self.all[i] = self.all[i-1] + self.all[i-2]
        a = []
        while num > 0:
            a.append(num % 2)
            num = num // 2
        a.reverse()
        length = len(a)
        #print(a)
        res = self.countLimit(0, 1, length, a, True)
        #print(res)
        for i in range(1, length):
            res += self.all[i]
        # add 0 to solutions
        return res + 1
```

all数组表示1开头符合条件的数的数量，本来是通过count函数来搜索的，后来发现是斐波那契数列就直接算了。countLimit用来搜索长度与n相同的数，top用来标记当前位是否与n一样大，如果当前第i位是1并且已经不是最大的，那就说明从第i位开始就可以随意选1和0了，加了这个剪枝就过了。

下面是官方题解的
