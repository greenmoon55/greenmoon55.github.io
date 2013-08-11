---
author: admin
comments: true
date: 2008-03-09 10:42:05+00:00
layout: post
slug: qsort-practice
title: Qsort练习
wordpress_id: 22
categories:
- Programming
---

好久不编了，连这种都有点不熟了。
PS：在这里发代码太费劲了。。 :evil:<!-- more -->

```pascal 

program qsortpractice080309;
type
		tbox = record
				x, y: longint;
		end;
var
		a: array[1..10] of tbox;
		i: longint;
procedure qsort(left, right: longint);
var
		i, j: longint;
		n: tbox;
begin
		i := left;
		j := right;
		n := a[i];
		while i < j do
		begin
				while (i < j) and ((a[j].x > n.x) or ((a[j].x = n.x) and (a[j].y >= n.y))) do dec(j);
				a[i] := a[j];
				while (i < j) and ((a[i].x < n.x) or ((a[i].x = n.x) and (a[i].y <= n.y))) do inc(i);
				a[j] := a[i];
		end;
		a[i] := n;
		if i < right then qsort(i + 1, right);
		if i > left then qsort(left, i - 1);
end;
begin
		assign(input, 'qsort.in');
		reset(input);
		for i := 1 to 10 do
		begin
				read(a[i].x, a[i].y);
				readln;
		end;
		qsort(1, 10);
		for i := 1 to 10 do write(a[i].x, ' ', a[i].y, '   ');
		close(input);
end.

```

