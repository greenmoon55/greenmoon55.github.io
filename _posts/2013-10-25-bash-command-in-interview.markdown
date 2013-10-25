---
layout: post
title: Bash 找出最大的数
---

随机生成一些数据

```bash
#!/bin/bash
for i in {1..10}
do
  printf "%d\t%d\n" $i $RANDOM
done
```

```
1       2879
2       28792
3       91
4       23059
5       8242
6       13228
7       31060
8       12015
9       25696
10      27964
```

现在要找出右边第三大的数

```
sort -k2 -n -r temp.txt | sed -n '3p'
```

* -k2 说明按第二列排序
* -n 说明当作数字排序
* -r 说明由大到小

详见 [explainshell.com](http://explainshell.com/explain?cmd=sort+-k2+-n+-r+temp.txt+%7C+sed+-n+%273p%27)

[sed 简明教程   酷壳 - CoolShell.cn](http://coolshell.cn/articles/9104.html)

这是百度的面试题和某公司的笔试题
