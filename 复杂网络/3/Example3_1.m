N=input('�������������������нڵ����� N��');
K=input('��������������������ÿ���ڵ���ھ��� K��');
if K>floor(N-1)|mod(K,2)~=0
    disp('�����������Kֵ������С������ڵ�������Ϊż��������');
    return;
end
angle=0:2*pi/N:2*pi-2*pi/N;
x=100*sin(angle);
y=100*cos(angle);
plot(x,y,'ro','markeredgecolor','g','markerfacecolor','r','markersize',8);
hold on
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