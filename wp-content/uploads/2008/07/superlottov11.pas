program superlotto;
var
    num:array[1..5] of longint;
    used:array[1..35] of boolean;
    i,j,k:longint;
    x,y,t,n:longint;
begin
writeln('超级大乐透随机选号程序V1.1');
writeln('欢迎访问http:greenmoon55.cn/blog');
while true do
begin
    write('请输入生成组数：');
    readln(n);
    randomize;
    for i:=1 to n do
    begin
        fillchar(used,sizeof(used),false);
        for j:=1 to 5 do
        begin
            num[j]:=random(35)+1;
            while used[num[j]] do num[j]:=random(35)+1;
            used[num[j]]:=true;
        end;
        for j:=1 to 4 do
            for k:=j+1 to 5 do
            if num[j]>num[k] then
            begin
                t:=num[j];
                num[j]:=num[k];
                num[k]:=t;
            end;
        x:=random(12)+1;
        y:=random(12)+1;
        while x=y do y:=random(12)+1;
        if x<y then
        begin
            t:=x;
            x:=y;
            y:=t;
        end;
        for j:=1 to 5 do write(num[j]:3);
        writeln(x:4,y:3);
    end;
end;
end.
