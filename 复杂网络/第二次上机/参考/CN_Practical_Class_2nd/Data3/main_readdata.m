%从原始数据中读取数据
tic;
fid=fopen('./power/power.gml'); %从原始数据中读取数据
tline=fgetl(fid);
while ~strcmp(strtrim(tline),'edge')  %一直读取到这一行“edge”为止
    tline=fgetl(fid);
end
num_edge=0;
while ~feof(fid)
    tline=fgetl(fid); %这一行为“[”
    
    tline1=fgetl(fid); %这一行为“source ”开头的
    trim_tline1=strtrim(tline1);%去掉字符串首尾多余的空格
    S1=regexp(trim_tline1, ' ', 'split'); %用中间的那个空格去划分这个字符串，可以得到源节点的编号
    num_edge=num_edge+1;
    Edges(num_edge,1)=eval(S1{2});  %将cell类型的数据转化为数值格式，Edges为一个两列的矩阵，每一行代表一条边
    
    tline2=fgetl(fid); %这一行为“target ”开头的
    trim_tline2=strtrim(tline2);%去掉字符串首尾多余的空格
    S2=regexp(trim_tline2, ' ', 'split'); %用中间的那个空格去划分这个字符串，可以得到目标节点的编号
    Edges(num_edge,2)=eval(S2{2});  %将cell类型的数据转化为数值格式
    
    tline=fgetl(fid); %这一行为“]”
    tline=fgetl(fid); %这一行为“edge”
end
fclose(fid);
csvwrite('USpower.dat',Edges);

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

% %%
% %下面找到这个原始网络的最大连通子图
% LB=largest_component(AdjMatrixSparse); %最大连通子图的稀疏矩阵形式LB，且这时的编号是连续的
% [r_index,c_index,value]=find(LB);%即提取最大连通子图稀疏矩阵的三列元素
% AdjMatrixLargestCom=[r_index,c_index];
% dm_DC=max(r_index);%因为LB的指标是连续变化的，所以dm_DC就是最大连通子图LB的节点个数
% num_edg=size(r_index,1);

% DisLargestComMatrix=all_shortest_paths(LB); %最大连通子网络的最短距离矩阵
% DiaLargestCom=max(max(DisLargestComMatrix)); %最大连通子网络的直径。

%%
%数据的存储
dlmwrite('SparseAdjMatrix.dat',Edges,'precision','%.0f');
dlmwrite('V.dat',NumOfNodes,'precision','%.0f');
dlmwrite('Diameter.dat',DiaRaw,'precision','%.0f');

ElapsedTime=toc;
csvwrite('ElapsedTime.dat',ElapsedTime);