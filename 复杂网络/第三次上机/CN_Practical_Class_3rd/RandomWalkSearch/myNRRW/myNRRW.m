function [T,TV] = myNRRW(C,s,t)
%myNRRW ��������һ���ڵ������������� NRRW�� CΪM*2�ľ���ÿһ�д���һ������ߣ�MΪ�ߵ���������sΪԴ�ڵ㣬tΪĿ��ڵ㣬TΪ����������TVΪ������ȫ���ڵ�
N=max(max(C)); %�����ģ
C=[C;C(:,2) C(:,1)]; %�����ǵ�����Ϊ�������磬�������ӷ���ı�
B=sparse(C(:,1),C(:,2),ones(size(C,1),1),N,N); %������Cת��Ϊϡ�����
A=full(B); %��������ڽӾ����ϡ���ʽת��Ϊ�ڽӾ���
T=0;TV=s;V=s; %TVΪȫ���ѷ��ʵĽڵ㣬VΪ��ǰ�ڵ�
if s==t
    return;
end
last_node=s;
while A(V,t)~=1
    nodes=find(A(V,:)==1); %���ҵ�ǰ�ڵ���ھӽڵ�
    nodes=setdiff(nodes,last_node);
    if length(nodes)==0
        next_node=last_node; TV=[TV,next_node];
        last_node=V; V=next_node;T=T+1;continue
    end  
    r=rand(1,length(nodes)); %����һ��[0,1]�����ϵ��������
    [sr,ind]=sort(r); %���մ�С��������
    next_node=nodes(ind(1)); %������һ���ڵ�
    TV=[TV next_node];
    last_node=V; V=next_node;
    T=T+1;
end
TV=[TV,t];T=T+1;
end

