%pagerank
P1=zeros(8);
P1(1,2)=1;P1(2,[1 6])=1;P1(3,[2 4 5])=1;P1(4,3)=1;P1(5,4)=1;
P1(6,[2 4 7])=1;P1(7,6)=1;P1(8,6)=1; 
P=[];
[~,n]=size(P1);
for i=1:n
    P=[P;P1(i,:)/sum(P1(i,:))];
end
d=0.85;    %����ϵ��
sigma=0.0001;    %������ֵ
e=ones(n,1);
A=d*P'+(1-d)*((e*e')/n);
x=ones(n,1);    %ҳ���pagerank��ʼֵ
r=A*x;       %pagerank�ļ��㹫ʽ
while(norm(r-x)>=sigma)    %�ж��Ƿ�����
    x=r;
    r=A*x;
end
r