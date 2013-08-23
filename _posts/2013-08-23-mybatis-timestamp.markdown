---
layout: post
title: MyBatis 与 MySQL Timestamp 类型的问题
---

正常使用时，找不到对应的记录，MyBatis 的日志是这样的。

```
[DEBUG] 25:52/(BaseJdbcLogger.java:debug:132)
==>  Preparing: SELECT COUNT(id) FROM paths WHERE task_id = ? AND time = ?

[DEBUG] 25:52/(BaseJdbcLogger.java:debug:132)
==> Parameters: 255103(Integer), 2013-08-22 13:40:02.208(Timestamp)
```

根据 [MySQL 的官方文档](http://dev.mysql.com/doc/refman/5.5/en/datetime.html)

> TIMESTAMP has a range of '1970-01-01 00:00:01' UTC to '2038-01-19 03:14:07' UTC.

经过测试，把毫秒设为 0 就能正常查找了，也就是`2013-01-01 02:03:04.000`。

MyBatis 挺好用的，据说公司里用得挺多的。(我还是不想写 Java = =)
