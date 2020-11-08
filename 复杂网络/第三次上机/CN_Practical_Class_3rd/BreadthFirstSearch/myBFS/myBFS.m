function [T,U] = myBFS(C,s,t)
%myBFS ����������� BFS��CΪM*2�ľ���ÿһ�д���һ������ߣ�MΪ�ߵ���������sΪԴ�ڵ㣬tΪĿ��ڵ㣬TΪ��������
N=max(max(C)); %�����ģ
C=[C;C(:,2) C(:,1)]; %�����ǵ�����Ϊ�������磬�������ӷ���ı�
B=sparse(C(:,1),C(:,2),ones(size(C,1),1),N,N); %������Cת��Ϊϡ�����
A=full(B); %��������ڽӾ����ϡ���ʽת��Ϊ�ڽӾ���
T=0;TV=s;U=s; %TVΪ��ǰ�ڵ㣬UΪ�ѷ��ʽڵ㼯��
if s==t
    T=0; return;
end
while ~ismember(t,TV)
    T=T+1;
    n=length(TV); %��ǰ�ڵ�ĸ���
    TV2=[]; %�µĵ�ǰ���ʼ��
    for i=1:n
        nodes=find(A(TV(i),:)==1); %���ҵ�ǰ�ڵ���ھӽڵ�
        V=setdiff(nodes,U);
        TV2=[TV2,V];
        U=[U,V];
    end
    TV=TV2; %�µĵ�ǰ�ڵ�
end
end

