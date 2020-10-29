%该程序用来读取数据
clear;
clc;
tic;
filename = 'facebook_combined.txt';
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

A = full(AdjMatrixSparse);
fprintf('直径: %f\n',DiaRaw)
fprintf('平均距离: %f\n',sum(sum(DisRawMatrix))/(NumOfNodes^2))
fprintf('平均度: %f\n',average_degree(A))
[a,b,c]= clust_coeff(A);
fprintf('平均集聚系数: %f\n',b)

figure(1);
a = tabulate(degrees(A));
x = a(:,1);
y = a(:,3)/100;
plot(x,y)
str1 = ['总数N：',num2str(NumOfNodes),',边数K：',num2str(length(Edges)/2)];
title(str1)

figure(2);
a = tabulate(degrees(A));
x = a(:,1);
y = a(:,3)/100;
plot(x,log(y))
str1 = ['总数N：',num2str(NumOfNodes),',边数K：',num2str(length(Edges)/2),'对数坐标系'];
title(str1)