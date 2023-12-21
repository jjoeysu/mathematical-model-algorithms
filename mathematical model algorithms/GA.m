clear;
clc;
%输入城市距离矩阵
D=[0,56,35,21,51,60;56,0,21,57,78,70;35,21,0,36,68,68;...
    21,57,36,0,51,61;51,78,68,51,0,13;60,70,68,61,13,0];
n=6;%输入城市数目
m=10;%初始种群大小
k=50;%遗传代数
r=0.03;%变异系数（概率）
A=start(n,m);%生成初始种群
B=A;
%交配遗传变异选择过程，选出和初始种群大小相等的较优子代
for i=1:k
B=mating(B,D,r);
end
d=zeros(m);
%计算各路线总路程
for i=1:m
    for j=1:n
        if(j==n)
        d(i)=d(i)+D(B(j,i),B(1,i));
        else
        d(i)=d(i)+D(B(j,i),B(j+1,i));
        end
    end
end
%选择最优路线，并输出最短路程
[d1,index]=sort(d);
route=B(:,index(1))'
distance=d1(1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%初始种群生成函数%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function[A]=start(n,m)
A=zeros(n,m);
for i=1:m
A(:,i)=randperm(n)';
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%遗传变异选择函数%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function[C]=mating(A,D,r)
[n,m]=size(A);
B=zeros(n,2*m);d=zeros(2*m);C=zeros(n,m);
for i=1:m
    a=0;
    if(i==m)
    a1=A(:,m);
    a2=A(:,1);
    else
    a1=A(:,i);
    a2=A(:,i+1);
    end
    for j=n:2
        for k=n:2
    if(a1(j)==a2(k-1)&&a1(j-1)==a2(k))
        x=a1(j);y=a1(j-1);
        a1(j)=a2(k);a1(j-1)=a2(k-1);
        a2(k)=x;a2(k-1)=y;
        a=1;
    end
        if(a==1)
            break
        end
        end
        if(a==1)
            break
        end
    end
    B(:,2*i-1)=a1;B(:,2*i)=a2;
end
for i=1:2*m
    r0=rand(1);
    if(r0<=r)
        r1=floor(rand(1)*5+1);r2=floor(rand(1)*5+1);
        z=B(r1,i);B(r1,i)=B(r2,i);B(r2,i)=z;
    end
    for j=1:n
        if(j==n)
        d(i)=d(i)+D(B(j,i),B(1,i));
        else
        d(i)=d(i)+D(B(j,i),B(j+1,i));
        end
    end
end
[~,index]=sort(d);
for i=1:m
    C(:,i)=B(:,index(i));
end
end