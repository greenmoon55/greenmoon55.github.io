---
layout: post
title: Const Reference To Pointer
---

```cpp
struct mycomp {
    bool operator()(ListNode * const &a, ListNode * const &b) {
        return a->val > b->val;
    }
};
```
上学期 euyuil 曾经讲过这方面的东西，现在终于用到了。之前一直写成 `const ListNode *`，还不明白为什么不对。

这里重载括号也挺有意思，这种东西叫做 functor，我还没想明白为什么不能直接传名为 mycomp 的函数过去。

[9.9 — Overloading the parenthesis operator « Learn C++](http://www.learncpp.com/cpp-tutorial/99-overloading-the-parenthesis-operator/)

LeetCode 很不错，网页上的代码编辑器做得相当好，和本地的 CodeBlocks 差不多了。写 C++ 也想把左括号放到行尾了，可惜 CodeBlocks 自动缩进有问题。

