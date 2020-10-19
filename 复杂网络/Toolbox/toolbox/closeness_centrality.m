function [CC,aver_CC]=Closeness_Centrality(A)
%% 求复杂网络中两节点的距离以及平均路径长度
%% 求解算法：首先利用Floyd算法求解出任意两节点的距离，再求距离的平均值得平均路径长度
%  A————————网络图的邻接矩阵
%  D————————返回值：网络图的距离矩阵
%  aver_D———————返回值：网络图的平均路径长度
 N=size(A,2);
 D=A;
 D(find(D==0))=inf;    %将邻接矩阵变为邻接距离矩阵，两点无边相连时赋值为inf，自身到自身的距离为0.
 for i=1:N           
     D(i,i)=0;       
 end   
 for k=1:N            %Floyd算法求解任意两点的最短距离
     for i=1:N
         for j=1:N
             if D(i,j)>D(i,k)+D(k,j)
                D(i,j)=D(i,k)+D(k,j);
             end
         end
     end
 end
 CC=zeros(1,N);
 D(find(D==inf))=0;
 for i=1:N
     CC(i)=(N-1)/sum(D(i,:));%Closeness centrality
     %if sum(D(i,:))==inf
        % CC(i)=0;
 %end
 end
  aver_CC=sum(CC)/N;  %平均cc
 
