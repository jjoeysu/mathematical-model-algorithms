clear;
clc;
%输入城市距离矩阵
D=[0,56,35,21,51,60;56,0,21,57,78,70;35,21,0,36,68,68;...
    21,57,36,0,51,61;51,78,68,51,0,13;60,70,68,61,13,0];
n=6;%输入城市数目
w=1000;%防干扰系数
s=zeros(2,n-1);d=zeros(1,n-1);
s(1,1)=1;%选定初始点
for i=1:n
    D(i,i)=w;
end
%从初始点开始生成树
for i=1:n-1
if(i==1)
    [b1,p1]=sort(D(:,s(1,1)));
    d(1)=b1(1);s(2,1)=p1(1);
    D(s(1,1),:)=w;D(s(2,1),:)=w;
else
    l=0;B=zeros(1,2*(i-1));P=zeros(n);
    for k=1:i-1
        for j=1:2
            l=l+1;
            [b1,p1]=sort(D(:,s(j,k)));
            B(l)=b1(1);P(l)=p1(1);
        end
    end
    [b,p]=sort(B);d(i)=b(1);
    s(1,i)=s(mod(p(1)-1,2)+1,floor((p(1)-1)/2)+1);s(2,i)=P(p(1));
    D(s(2,i),:)=w;
    sd=[s;d];
    distance=sum(d);
end
end
%输出最小生成树包括的航线以及航线总长
fprintf('MST = \n');
disp(sd);
fprintf('distance = %d\n\n',distance);




