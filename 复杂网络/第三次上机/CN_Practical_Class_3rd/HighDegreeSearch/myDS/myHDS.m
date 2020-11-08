function [T,V,d,path] = myHDS(C,s,t)
%myHDS 最大度搜索 HDS，C为M*2的矩阵（每一行代表一条单向边，M为边的数量），s为源节点，t为目标节点，T为搜索步数，V为经过的节点，path为应用HDS得到的最短路径，d为路径长度，CV为当前节点
C=[C;C(:,2) C(:,1)]; %若考虑的网络为无向网络，则必须添加反向的边
B=sparse(C(:,1),C(:,2),ones(size(C,1),1)); %将矩阵A转化为稀疏矩阵
A=full(B); %将网络的邻接矩阵的稀疏格式转化为邻接矩阵
T=0;V=s;path=s; d=0; CV=s; 
if s==t
    return;
end
deg=sum(A); %计算节点度
flag=zeros(size(A)); %记录边是否被访问的标志矩阵
while A(CV,t)~=1
    [row,NV]=find(A(CV,:)==1); %查找当前节点的邻居节点
    cdeg=deg(NV); %提取所有邻居节点的度
    ind=find(cdeg==max(cdeg),1); %查找度最大的第一个节点
    L=length(V);
    while flag(CV,NV(ind))==1 %路径已经访问过
        NV(ind)=[]; %删除当前最大度节点
        if length(NV)
            cdeg=deg(NV); %提取备选邻居节点的度
            ind=find(cdeg==max(cdeg),1); %查找度最大的第一个节点
        else
            L=L-1;CV=V(L);
            [row,NV]=find(A(CV,:)==1); %提取回溯节点的邻居节点
            cdeg=deg(NV); %提取邻居节点的度
            ind=find(cdeg==max(cdeg),1,'last'); %查找度最大的最后节点
        end
    end
    flag(CV,NV(ind))=1;flag(NV(ind),CV)=1;CV=NV(ind);
    V=[V,CV];T=T+1;
end
V=[V,t];T=T+1;

%%
LV=V;CV=s; %以下求最短路径
while CV~=t
    no=find(LV==CV);d=d+1;
    if length(no)==1
        CV=LV(d+1);path=[path,CV];
    else
        LV(no(1)+1:no(end))=[]; %删除中间重复节点
        CV=LV(d+1);path=[path,CV];
    end
end
end

