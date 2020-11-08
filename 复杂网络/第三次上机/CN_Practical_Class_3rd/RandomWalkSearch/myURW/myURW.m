function [T,TV] = myURW(C,s,t)
%myURW 无限制的随机游走搜索 URW， C为M*2的矩阵（每一行代表一条单向边，M为边的数量），s为源节点，t为目标节点，T为搜索步数，TV为遍历的全部节点
N=max(max(C)); %网络规模
C=[C;C(:,2) C(:,1)]; %若考虑的网络为无向网络，则必须添加反向的边
B=sparse(C(:,1),C(:,2),ones(size(C,1),1),N,N); %将矩阵C转化为稀疏矩阵
A=full(B); %将网络的邻接矩阵的稀疏格式转化为邻接矩阵
T=0;TV=s;V=s; %TV为全部已访问的节点，V为当前节点
if s==t
    return;
end
while A(V,t)~=1
    nodes=find(A(V,:)==1); %查找当前节点的邻居节点
    r=rand(1,length(nodes)); %产生一个[0,1]区间上的随机向量
    [sr,ind]=sort(r); %按照从小到大排列
    next_node=nodes(ind(1)); %查找下一个节点
    TV=[TV next_node];
    V=next_node;
    T=T+1;
end
TV=[TV,t];T=T+1;
end

