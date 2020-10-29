clear;
clc;
N=input('�������������������нڵ����� N��');
K=input('��������������������ÿ���ڵ���ھ��� K��');
if K>floor(N-1)|mod(K,2)~=0
    disp('�����������Kֵ������С������ڵ�������Ϊż��������');
    return;
end
%{
figure(1);
angle=0:2*pi/N:2*pi-2*pi/N;
x=100*sin(angle);
y=100*cos(angle);
plot(x,y,'ro','markeredgecolor','g','markerfacecolor','r','markersize',8);
hold on
%}
A=zeros(N);
for i=1:N
    for j=i+1:i+K/2
        jj=j;
        if j>N
            jj=mod(j,N);
        end
        A(i,jj)=1;A(jj,i)=1;
    end
end
p=input('������������ӱߵĸ��� p��');
[m,n]=find(A==0);
for i=1:length(m);
    if m(i)~=n(i)
        p1=rand(1,1);
        if p>p1
            A(m(i),n(i))=1;
            A(n(i),m(i))=1;
        end
    end
end
%{
for i=1:N
    for j=i+1:N
        if A(i,j)==1
            plot([x(i),x(j)],[y(i),y(j)],'linewidth',1.2);
            hold on
        end
    end
end
axis equal;
hold off
edgeL2pajek(adj2edgeL(A),'NW.net')
%}
fprintf('ֱ��: %d\n',diameter(A))
fprintf('ƽ������: %f\n',ave_path_length(A))
fprintf('ƽ����: %f\n',average_degree(A))
fprintf('ƽ������ϵ��: %f\n',clust_coeff(A))

figure(2);
a = tabulate(degrees(A));
x = a(:,1);
y = a(:,3)/100;
plot(x,y)
str1 = ['����N��',num2str(N),',�ھ���K��',num2str(K),',p��',num2str(p)];
title(str1)