---
author: admin
comments: true
date: 2010-03-15 16:46:28+00:00
layout: post
slug: usaco-name-that-number
title: USACO Name That Number
wordpress_id: 178
categories:
- Programming
tags:
- USACO
---

逆向思维，读入词典中与数字长度相同的名字，再把名字转化为数字一位一位比较。
学到了：switch, case, strlen()。
**UPDATE @ 2010/3/16 0:55**
**看USACO给的答案，其实是可以读一个处理一个不开数组的。。。懒得改了**

```c 

/*
TASK: namenum
LANG: C
ID: djgreen1
*/
#include 
#include 
#include 
char work(char ch)
{
    switch (ch)
    {
        case 'A':case 'B':case 'C': return '2';
        case 'D':case 'E':case 'F': return '3';
        case 'G':case 'H':case 'I': return '4';
        case 'J':case 'K':case 'L': return '5';
        case 'M':case 'N':case 'O': return '6';
        case 'P':case 'R':case 'S': return '7';
        case 'T':case 'U':case 'V': return '8';
        case 'W':case 'X':case 'Y': return '9';
    }
}
int main()
{
    char num[13]={0},dict[5000][13],temp[13]={0};
    FILE *in=fopen("namenum.in","r"),*txt=fopen("dict.txt","r"),*out=fopen("namenum.out","w");
    int length,i,j,k;
    bool find,none=true;

    fscanf(in,"%s",num);
    fclose(in);
    length=strlen(num);
    for (i=0;fscanf(txt,"%s",temp)!=EOF;)//find name with the same length
    if (strlen(temp)==length)
    {
        for (j=0;j<length;j++)dict[i][j]=temp[j];
        i++;
    }
    fclose(txt);
    for (j=0;j<i;j++)//start comparation
    {
        find=true;
        for (k=0;k<length;k++)
        {
            if (work(dict[j][k])!=num[k])
            {
                find=false;
                break;
            }
        }
        if (find)
        {
            none=false;
            fprintf(out,"%s\n",dict[j]);
        }
    }
    if (none) fprintf(out,"NONE\n");
    fclose(out);
    return 0;
}

```

