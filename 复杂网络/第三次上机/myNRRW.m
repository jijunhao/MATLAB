function [T,TV] = myNRRW(A,s,t)
%myNRRW 不返回上一步节点的随机游走搜索 NRRW
T=0;TV=s;V=s; %TV为全部已访问的节点，V为当前节点
if s==t
    return;
end
last_node=s;
while A(V,t)~=1
    nodes=find(A(V,:)==1); %查找当前节点的邻居节点
    nodes=setdiff(nodes,last_node);
    if length(nodes)==0
        next_node=last_node; TV=[TV,next_node];
        last_node=V; V=next_node;T=T+1;continue
    end  
    r=rand(1,length(nodes)); %产生一个[0,1]区间上的随机向量
    [sr,ind]=sort(r); %按照从小到大排列
    next_node=nodes(ind(1)); %查找下一个节点
    TV=[TV next_node];
    last_node=V; V=next_node;
    T=T+1;
end
TV=[TV,t];T=T+1;
end

