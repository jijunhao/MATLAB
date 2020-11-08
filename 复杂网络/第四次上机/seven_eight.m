clear,
A=zeros(34); %Zachary网络邻接矩阵初始化
A(1,[2:9,11:14,18,20,22,32])=1;
A(2,[3,4,8,14,18,20,22,31])=1;
A(3,[4,8:10,14,28,29,33])=1;
A(4,[8,13,14])=1;A(5,[7,11])=1;
A(6,[7,11,17])=1;A(7,17)=1;
A(9,[31,33,34])=1;A(10,34)=1;
A(14,34) =1;A(15,[33,34])=1;
A(16,[33,34])=1; A(19,[33,34])=1;A(20,34)=1; A(21,[33,34])=1;
A(23,[33,34]) =1; A(24,[26,28,30,33,34])=1; A(25 ,[26,28,32])=1; A(26,32)=1;
A(27,[30,34]) =1; A(28,34)=1; A(29,[32,34])=1; A(30,[33,34])=1;
A(31,[33,34])=1; A(32,[33,34])=1;A(33,34)=1;
A=A+A'; L=diag(sum(A))-A;
[vec,val] =eigs(L,2,'smallestabs');
b1 = find(vec(:,2) <0);b2 =find(vec(:,2)>0);
A=A'; A=sparse(A); 
name = cellstr(int2str([1:34]'));
h = view(biograph(A,name,'ShowArrows','off','ShowWeights','off'));
h.EdgeType = 'segmented'; %边的连接为线段
h.LayoutType = 'equilibrium'; %网络布局类型为平衡结构
bh1 =[1:8,11:14,17,18,20,22]; bh2 =setdiff([1:34],bh1);
set(h .Nodes(bh2), 'shape','circle'); %修改顶点形状
set(h .Nodes(b1),'Color' ,[0,1,1]); %修改顶点填充颜色
set(h.Edges, 'LineColor',[0 0 0]);
set(h.Edges, 'LineWidth',1.5); %线型宽度设置为1.5
dolayout(h) %刷新图形