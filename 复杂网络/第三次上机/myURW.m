function [T,TV] = myURW(A,s,t)
%myURW �����Ƶ������������ URW
T=0;TV=s;V=s; %TVΪȫ���ѷ��ʵĽڵ㣬VΪ��ǰ�ڵ�
if s==t
    return;
end
while A(V,t)~=1
    nodes=find(A(V,:)==1); %���ҵ�ǰ�ڵ���ھӽڵ�
    r=rand(1,length(nodes)); %����һ��[0,1]�����ϵ��������
    [sr,ind]=sort(r); %���մ�С��������
    next_node=nodes(ind(1)); %������һ���ڵ�
    TV=[TV next_node];
    V=next_node;
    T=T+1;
end
TV=[TV,t];T=T+1;
end

