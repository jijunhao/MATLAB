function [T,TV] = mySARW(A,s,t)
%mySARW 不重复访问节点的随机游走搜索 SARW
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

