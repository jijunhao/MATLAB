function [T,TV] = mySARW(C,s,t)
%mySARW 不重复访问节点的随机游走搜索 SARW， C为M*2的矩阵（每一行代表一条单向边，M为边的数量），s为源节点，t为目标节点，T为搜索步数，TV为遍历的全部节点
N=max(max(C)); %网络规模
C=[C;C(:,2) C(:,1)]; %若考虑的网络为无向网络，则必须添加反向的边
B=sparse(C(:,1),C(:,2),ones(size(C,1),1),N,N); %将矩阵C转化为稀疏矩阵
A=full(B); %将网络的邻接矩阵的稀疏格式转化为邻接矩阵
T=0;TV=s;V=s; %TV为全部已访问的节点，V为当前节点
if s==t
    return;
end
while A(V,t)~=1
    nodes1=find(A(V,:)==1); %查找当前节点的邻居节点
    nodes2=setdiff(nodes1,TV); %求未访问过的邻居节点
    if length(nodes2)>=1 %有未被访问的邻居节点
        r=rand(1,length(nodes2)); %产生一个[0,1]区间上的随机向量
        [sr,ind]=sort(r); %按照从小到大排列
        next_node=nodes2(ind(1)); %查找下一个节点
    else %邻居节点全部被访问过
        r=rand(1,length(nodes1)); %产生一个[0,1]区间上的随机向量
        [sr,ind]=sort(r); %按照从小到大排列
        next_node=nodes1(ind(1)); %查找下一个节点
    end
    TV=[TV next_node];
    V=next_node;
    T=T+1;
end
TV=[TV,t];T=T+1;
end

