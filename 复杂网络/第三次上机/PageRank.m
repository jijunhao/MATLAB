%pagerank
P1=zeros(8);
P1(1,2)=1;P1(2,[1 6])=1;P1(3,[2 4 5])=1;P1(4,3)=1;P1(5,4)=1;
P1(6,[2 4 7])=1;P1(7,6)=1;P1(8,6)=1; 
P=[];
[~,n]=size(P1);
for i=1:n
    P=[P;P1(i,:)/sum(P1(i,:))];
end
d=0.85;    %阻尼系数
sigma=0.0001;    %收敛阈值
e=ones(n,1);
A=d*P'+(1-d)*((e*e')/n);
x=ones(n,1);    %页面的pagerank初始值
r=A*x;       %pagerank的计算公式
while(norm(r-x)>=sigma)    %判断是否收敛
    x=r;
    r=A*x;
end
r