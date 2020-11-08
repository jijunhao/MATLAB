function [T,TV] = myURW(A,s,t)
%myURW 无限制的随机游走搜索 URW
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

