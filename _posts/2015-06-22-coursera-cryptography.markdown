---
layout: post
title: Coursera Cryptography
published: true
---

大学的时候之前尝试过两次，都没跟下来，这次终于学完了。。

密码学是什么？在学这门课之前，我只有这些印象：

1. 课程项目写用户注册的时候要 hash+salt
2. Rails 会把 session 信息存在 cookie 里，为了防止被篡改，cookie 里还有个 HMAC，用到了secret key。[link](http://stackoverflow.com/questions/13786320/rails-where-is-message-digest-of-sessions-using-default-cookiestore)
3. SSH keypair

目标主要有两个：confidentiality and integrity。要保证confidentiality，就要选择各种加密方法，要保证integrity，就要用到MAC。
两种都保证了，就可以说实现了authenticated encryption。

好吧，那接下来看看都讲了啥。。自己整理一下：

第一周：Stream Cipher, One-time Pad, PRG

第二周：Block Cipher, AES, DES, PRG, PRF, CBC, CTR

第三周：Secure MAC, Birthday Attack, Merkle–Damgard iterated construction

第四周：Authenticated Encryption, Encrypt-then-MAC, Padding Oracle, HKDF, PBKDF

第五周：Diffie-Hellman protocol, Fermat, Euler, DLOG

第六周：Trapdoor Functions, RSA, PKCS1 v1.5, PKCS1 v2.0: OAEP, EIGamal

现在感觉只是大概了解了这些概念和数学证明，习题做得太少，已经忘了一些了。。知道这些已经知足啦，期待Part 2:)
