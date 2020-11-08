function [T,U] = myBFS(C,s,t)
%myBFS 广度优先搜索 BFS，C为M*2的矩阵（每一行代表一条单向边，M为边的数量），s为源节点，t为目标节点，T为搜索步数
N=max(max(C)); %网络规模
C=[C;C(:,2) C(:,1)]; %若考虑的网络为无向网络，则必须添加反向的边
B=sparse(C(:,1),C(:,2),ones(size(C,1),1),N,N); %将矩阵C转化为稀疏矩阵
A=full(B); %将网络的邻接矩阵的稀疏格式转化为邻接矩阵
T=0;TV=s;U=s; %TV为当前节点，U为已访问节点集合
if s==t
    T=0; return;
end
while ~ismember(t,TV)
    T=T+1;
    n=length(TV); %当前节点的个数
    TV2=[]; %新的当前点初始化
    for i=1:n
        nodes=find(A(TV(i),:)==1); %查找当前节点的邻居节点
        V=setdiff(nodes,U);
        TV2=[TV2,V];
        U=[U,V];
    end
    TV=TV2; %新的当前节点
end
end

