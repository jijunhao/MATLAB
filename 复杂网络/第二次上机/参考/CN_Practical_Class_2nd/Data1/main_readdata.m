%该程序用来读取数据
tic;
filename = './bn-fly-drosophila_medulla_1/bn/bn-fly-drosophila_medulla_1.edges';
[EdgeFromNode,EdgeToNode]=textread(filename,'%n%n','delimiter', ' ');
Edges=[EdgeFromNode,EdgeToNode];

%%
%去掉到自身的环
index=(Edges(:,1)==Edges(:,2)); %得到自身到自身的环所在的行指标
Edges=Edges(~index,:); %提取不是环的行

%%
%经过上面取出的这个网络中的节点的编号可能不是连续的，下面转化为连续的；且把从0开始的编号变成从1开始
RawUniNodes=unique(Edges);%把Edges中所有节点都提出来
[Aindex,Edges]=ismember(Edges,RawUniNodes);

%%
%数据是无向网络，加入反向边
Edges=[Edges;[Edges(:,2),Edges(:,1)]];

%%
%去掉可能存在相同的行，即去掉重边
Edges=unique(Edges,'rows');

%%
%获得原始网络的稀疏矩阵
NumOfNodes=max(max(Edges));
AdjMatrixSparse=sparse(Edges(:,1)',Edges(:,2)',ones(1,size(Edges,1)),NumOfNodes,NumOfNodes);
IsNotSymm=isequal(AdjMatrixSparse,AdjMatrixSparse'); %判断AdjMatrixSparse是否为对称矩阵，如果是则返回值为1
if IsNotSymm~=1
    disp('The matrix is not a symmetric matrix.');
end
    
DisRawMatrix=all_shortest_paths(AdjMatrixSparse); %整个网络的最短距离矩阵
DiaRaw=max(max(DisRawMatrix)); %整个网络的直径

%%
%下面找到这个原始网络的最大连通子图
LB=largest_component(AdjMatrixSparse); %最大连通子图的稀疏矩阵形式LB，且这时的编号是连续的
[r_index,c_index,value]=find(LB);%即提取最大连通子图稀疏矩阵的三列元素
AdjMatrixLargestCom=[r_index,c_index];
dm_DC=max(r_index);%因为LB的指标是连续变化的，所以dm_DC就是最大连通子图LB的节点个数
num_edg=size(r_index,1);

DisLargestComMatrix=all_shortest_paths(LB); %最大连通子网络的最短距离矩阵
DiaLargestCom=max(max(DisLargestComMatrix)); %最大连通子网络的直径。

%%
%数据的存储
dlmwrite('SparseAdjMatrix.dat',Edges,'precision','%.0f');
dlmwrite('V.dat',NumOfNodes,'precision','%.0f');
dlmwrite('Diameter.dat',DiaRaw,'precision','%.0f');

ElapsedTime=toc;
csvwrite('ElapsedTime.dat',ElapsedTime);