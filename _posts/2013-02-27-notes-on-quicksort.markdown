---
author: admin
comments: true
date: 2013-02-27 11:20:18+00:00
layout: post
slug: '%e5%bf%ab%e6%8e%92%e7%ac%94%e8%ae%b0'
title: 快排笔记
wordpress_id: 418
categories:
- Programming
---

另一种快排的实现方法，[算法课](https://www.coursera.org/course/algo)讲的。感觉这个挺容易懂的，都忘了以前怎么写的了= =。

首先选择数组中第一个元素为 pivot，先不管它，引入 i, j 两个指针。从左向右扫描数组，j 分隔开扫描过的元素和未知的元素，从第二个元素到 i 之前都比 pivot 小，从 i 到 j 都比 pivot 大，当然等于 pivot 的元素放在哪边都可以啦。扫描时如果遇到比 pivot 小的元素，与 i 后面那个元素交换即可，然后再右移 i。最后交换第一个元素和 i 左边的数。

实际代码中 a[i] 表示数组中大于 pivot 的第一个数（当然也可能还没扫到），最后和 a[i-1] 交换。


```cpp 

int partition(int *a, int l, int r)
{
    int p = a[l]; // pivot
    int i = l + 1;
    for (int j = l + 1; j <= r; j++)
    {
        if (a[j] < p)
        {
            swap(a[j], a[i]);
            i++;
        }
    }
    swap(a[l], a[i - 1]);
    return i - 1;
}
void quicksort(int *a, int l, int r)
{
    int p = partition(a, l, r);
    if (l < p - 1) quicksort(a, l, p - 1);
    if (p + 1 < r) quicksort(a, p + 1, r);
}

```


如果选取其他 pivot 怎么办呢？先交换第一个数和新的 pivot 就可以了。
