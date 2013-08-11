---
author: admin
comments: true
date: 2008-05-31 23:24:22+00:00
layout: post
slug: the-castle
title: The Castle
wordpress_id: 50
categories:
- Programming
tags:
- USACO
---

翻译：[http://www.nocow.cn/index.php/Translate:USACO/castle](http://www.nocow.cn/index.php/Translate:USACO/castle)

比较简单，[走岛](http://greenmoon55.com/programing-problem-about-island/)、迷宫系列问题。重要问题：1.对墙的记录 2.对roomsize的求法 3.拆墙只需求墙两边的面积和。

另外，我准备用4个格的tab了，2个空格太短，8个格的tab太长。
<!-- more -->


```pascal 

{
ID:djgreen1
PROG:castle
LANG:PASCAL
}
program castlev1;
const
        dx              :array[1..4] of longint=(0,-1,0,1);
        dy              :array[1..4] of longint=(-1,0,1,0);
var
        wall            :array[1..50,1..50,1..4] of boolean;
        m,n,i,j,k       :longint;
        temp,roomnum    :longint;
        room            :array[1..50,1..50] of longint;
        roomsize        :array[1..2550] of longint;
        max,besti,bestj,bestd:longint;
procedure init;
begin
        readln(m,n);
        for i:=1 to n do
        begin
                for j:=1 to m do
                begin
                        read(temp);
                        for k:=1 to 4 do
                        begin
                                if temp mod 2>0 then wall[i,j,k]:=true;
                                temp:=temp div 2;
                        end;
                end;
                readln;
        end;
end;
procedure search(x,y,roomnum:longint);
var
        dir,tx,ty       :longint;
begin
        room[x,y]:=roomnum;
        inc(roomsize[roomnum]);
        for dir:=1 to 4 do
        begin
                if wall[x,y,dir] then continue;
                tx:=x+dx[dir];
                ty:=y+dy[dir];
                if (tx<1) or (tx>n) or (ty<1) or (ty>m) then continue;
                if room[tx,ty]=0 then search(tx,ty,roomnum);
        end;
end;
procedure size;
begin
        for i:=1 to n do
        for j:=1 to m do
        if room[i,j]=0 then
        begin
                inc(roomnum);
                search(i,j,roomnum);
        end;
end;
procedure delete;
begin
        for j:=1 to m do
        for i:=n downto 1 do
        begin
                if wall[i,j,2] then
                begin
                        if (i>1) and not (room[i-1,j]=room[i,j]) then
                        if roomsize[room[i-1,j]]+roomsize[room[i,j]]>max then
                        begin
                                max:=roomsize[room[i-1,j]]+roomsize[room[i,j]];
                                besti:=i;
                                bestj:=j;
                                bestd:=2;
                        end;
                end;
                if wall[i,j,3] then
                begin
                        if (j<m) and not (room[i,j]=room[i,j+1]) then
                        if roomsize[room[i,j+1]]+roomsize[room[i,j]]>max then
                        begin
                                max:=roomsize[room[i,j+1]]+roomsize[room[i,j]];
                                besti:=i;
                                bestj:=j;
                                bestd:=3;
                        end;
                end;
        end;
end;
begin
        assign(input,'castle.in');
        assign(output,'castle.out');
        reset(input);
        rewrite(output);
        init;
        close(input);
        fillchar(room,sizeof(room),0);
        fillchar(roomsize,sizeof(room),0);
        roomnum:=0;
        size;
        writeln(roomnum);
        max:=0;
        for i:=1 to roomnum do if roomsize[i]>max then max:=roomsize[i];
        writeln(max);
        max:=0;
        delete;
        writeln(max);
        write(besti,' ',bestj,' ');
        if bestd=2 then writeln('N') else writeln('E');
        close(output);
end.

```

**
Update @ 2010/5/25 0:50
**C语言版 

```c 

/*
ID:djgreen1
PROG:castle
LANG:C
*/
#include 
int roomnum=0,roomsize[2501]={0},m,n;
int map[51][51][5],room[51][51];
void search(int x,int y)
{
	const int dx[4]={0,-1,0,1},dy[4]={-1,0,1,0};
	int i;
	room[x][y]=roomnum;
	roomsize[roomnum]++;
	for (i=0;i<4;i++)
	{
		if (x+dx[i]<1 || x+dx[i]>n || y+dy[i]<1 || y+dy[i]>m) continue;
		if (map[x][y][i]) continue;
		if (room[x+dx[i]][y+dy[i]]==0) search(x+dx[i],y+dy[i]);
	}
}
int main()
{
	freopen("castle.in","r",stdin);
	freopen("castle.out","w",stdout);
	int i,j,k,temp,max,maxn,maxm;
	char maxd;

	scanf("%d%d",&m;,&n;);
	for (i=1;i<=n;i++)
		for (j=1;j<=m;j++)
		{
			scanf("%d",&temp;);
			for (k=0;k<4;k++)
			{
				map[i][j][k]=temp%2;
				temp=temp/2;
			}
		}
	for (i=1;i<=n;i++)
		for (j=1;j<=m;j++)
		{
			if (room[i][j]==0)
			{
				roomnum++;
				search(i,j);
			}
		}
	max=0;

	for (i=1;i<=roomnum;i++) 
		if (roomsize[i]>max)
		{
			max=roomsize[i];
		}
	printf("%d\n",roomnum);
	printf("%d\n",max);
	
	max=0;
	for (j=1;j<=m;j++)
		for (i=n;i>0;i--)
		{
			if (map[i][j][1]&&i;>1&&room;[i][j]!=room[i-1][j])
			{
				temp=roomsize[room[i][j]]+roomsize[room[i-1][j]];
				if (temp>max)
				{
					max=temp;
					maxn=i;
					maxm=j;
					maxd='N';
				}
			}
			if (map[i][j][2]&&j;<m&&room;[i][j]!=room[i][j+1])
			{
				temp=roomsize[room[i][j]]+roomsize[room[i][j+1]];
				if (temp>max)
				{
					max=temp;
					maxn=i;
					maxm=j;
					maxd='E';
				}
			}
		}
	printf("%d\n",max);
	printf("%d %d %c\n",maxn,maxm,maxd);
	fclose(stdin);
	fclose(stdout);
	return 0;
}

```

