---
author: admin
comments: true
date: 2012-02-12 04:46:47+00:00
layout: post
slug: hdu4119-isabellas-message
title: HDU4119 Isabella's Message
wordpress_id: 336
categories:
- Programming
tags:
- ACM
---

给定密文和密文中可能出现的单词，按题意输出原文。


```cpp 


#include 
#include 
#include 

using namespace std;

int n;
char map[55][55],temp[55][55],newmap[55][55],mask[55][55];
char word[5][2555];
char list[105][25];
char s[5][10100];
int ans[5][10100];

void rotate()
{
    for (int i=1;i<=n;i++)
    for (int j=1;j<=n;j++)
    newmap[j][n-i+1]=temp[i][j];
}
void getword(int num)
{
    int pos=0;
    for (int i=1;i<=n;i++)
    for (int j=1;j<=n;j++)
    {
        if (newmap[i][j]=='*') word[num][pos++]=map[i][j];
    }
}
int main()
{
    int t;
    int wordnum;

    freopen("1009.txt","r",stdin);

    scanf("%d",&t;);
    for (int tcase=1; tcase<=t;tcase++)
    {
        memset(s,0,sizeof(s));
        memset(word,0,sizeof(word));
        memset(ans,0,sizeof(ans));
        scanf("%d",&n;);
        for (int i=1;i<=n;i++) scanf("%s",map[i]+1);
        for (int i=1;i<=n;i++) scanf("%s",mask[i]+1);
        scanf("%d",&wordnum;);
        for (int i=0;i<wordnum;i++) scanf("%s",list[i]);

        memcpy(temp,mask,sizeof(mask));
        memcpy(newmap,mask,sizeof(mask));
        getword(0);
        for (int i=1;i<4;i++)
        {
            rotate();
            getword(i);
            memcpy(temp,newmap,sizeof(newmap));
        }

        //连接四句话
        for (int i=0;i<4;i++)
        {
            for (int j=i;j<i+4;j++)
            {
                strcat(s[i],word[j%4]);
            }
        }

        char tempword[10100];
        /*
        strcpy(s[0],"the..love..you....forever");
        strcpy(s[1],"love..you..forever");
        strcpy(s[2],"..love.the.forever");
        strcpy(s[3],"the.forver..love");
        */

        for (int i=0;i<4;i++)
        {
            int j=0;
            while (s[i][j]=='.' && j<strlen(s[i])) j++; //找到第一个单词...
            if (j>=strlen(s[i])) continue;

            int tpos;
            while (j<strlen(s[i]))
            {
                memset(tempword,0,sizeof(tempword));
                tpos=0;
                while (j<strlen(s[i]) && s[i][j]!='.')
                {
                    tempword[tpos++]=s[i][j++];
                }
                bool find = false;
                for (int k=0;k<wordnum;k++)
                {
                    if (!strcmp(tempword,list[k]))
                    {
                        find = true;
                        ans[i][0]++; //单词个数
                        ans[i][ans[i][0]]=k; //第几个单词
                        break;
                    }
                }
                if (!find)
                {
                    ans[i][0]=0;
                    break;
                }
		//多余的点
                while (j<strlen(s[i]) && s[i][j]=='.')
                {
                    j++;
                }
            }
        }
        bool find = false;
        int ar[10]; //存符合条件的方向
        memset(ar,0,sizeof(ar));
        int arsize=0;
        for (int i=0;i<4;i++)
        {
            if (ans[i][0])
            {
                find =true;
                ar[++arsize]=i;
            }
        }
        printf("Case #%d:",tcase);
        if (!find)
        {
            printf(" FAIL TO DECRYPT\n");
            continue;
        }

        int nar[10];
        int index =1;
        int minnode;
        while (arsize>1)
        {
            minnode=1; //字典序最小的序号
            //不停地找出字典序最小的那个...
            for (int j=1;j<=arsize;j++)
            {
                if (strcmp(list[ans[ar[j]][index]],list[ans[ar[minnode]][index]])<0) minnode=j;
            }
            int p=0;
	    //生成新数组（第一个单词是字典序最小的单词，且相同...）
            for (int j=1;j<=arsize;j++)
            {
                if (strcmp(list[ans[ar[j]][index]],list[ans[ar[minnode]][index]])==0) nar[++p]=ar[j];
            }
            arsize=p;
            memcpy(ar,nar,sizeof(nar));//新数组覆盖旧数组
            index++;
        }
        for (int i=1;i<=ans[ar[1]][0];i++)
        {
            printf(" %s",list[ans[ar[1]][i]]);
        }
        printf("\n");
    }
    return 0;
}

```


模拟题。
以前写的，我是怎么写出这么恶心的代码的...
