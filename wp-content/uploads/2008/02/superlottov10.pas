program caipiao;
var
	num		:array[1..5] of longint;
        used		:array[1..33] of boolean;
        i,j		:longint;
        n		:longint;
procedure qsort(left,right:longint);
var
	i,j,x		:longint;
begin
	i:=left;
        j:=right;
        x:=num[i];
        while i<j do
        begin
        	while (i<j) and (num[j]>x) do dec(j);
                num[i]:=num[j];
                while (i<j) and (num[i]<x) do inc(i);
                num[j]:=num[i];
        end;
        num[i]:=x;
        if i>left then qsort(left,i-1);
        if i<right then qsort(i+1,right);
end;
begin
	while true do
        begin	
		randomize;
		write('超级大乐透随机选号程序V1.0 请输入生成组数：');
        	readln(n);
		for j:=1 to n do
        	begin
        		fillchar(used,sizeof(used),false);
        		fillchar(num,sizeof(num),0);
        		for i:=1 to 5 do
        		begin
        			num[i]:=random(33)+1;
                		while used[num[i]] do num[i]:=random(33)+1;
                		used[num[i]]:=true;
        		end;	
        		qsort(1,5);
        		for i:=1 to 5 do write(num[i]:3);
               		num[1]:=random(12)+1;
                	num[2]:=random(12)+1;
                	while num[2]=num[1] do num[2]:=random(33)+1;
                	if num[2]<num[1] then
                	begin
                		i:=num[1];
                		num[1]:=num[2];
                        	num[2]:=i;
                	end;
                	writeln('  ',num[1]:3,num[2]:3);
        	end;
        end;
end.
