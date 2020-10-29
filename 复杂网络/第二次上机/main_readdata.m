%�ó���������ȡ����
clear;
clc;
tic;
filename = 'facebook_combined.txt';
[EdgeFromNode,EdgeToNode]=textread(filename,'%n%n','delimiter', ' ');
Edges=[EdgeFromNode,EdgeToNode];

%%
%ȥ��������Ļ�
index=(Edges(:,1)==Edges(:,2)); %�õ���������Ļ����ڵ���ָ��
Edges=Edges(~index,:); %��ȡ���ǻ�����

%%
%��������ȡ������������еĽڵ�ı�ſ��ܲ��������ģ�����ת��Ϊ�����ģ��ҰѴ�0��ʼ�ı�ű�ɴ�1��ʼ
RawUniNodes=unique(Edges);%��Edges�����нڵ㶼�����
[Aindex,Edges]=ismember(Edges,RawUniNodes);

%%
%�������������磬���뷴���
Edges=[Edges;[Edges(:,2),Edges(:,1)]];

%%
%ȥ�����ܴ�����ͬ���У���ȥ���ر�
Edges=unique(Edges,'rows');

%%
%���ԭʼ�����ϡ�����
NumOfNodes=max(max(Edges));
AdjMatrixSparse=sparse(Edges(:,1)',Edges(:,2)',ones(1,size(Edges,1)),NumOfNodes,NumOfNodes);
IsNotSymm=isequal(AdjMatrixSparse,AdjMatrixSparse'); %�ж�AdjMatrixSparse�Ƿ�Ϊ�Գƾ���������򷵻�ֵΪ1
if IsNotSymm~=1
    disp('The matrix is not a symmetric matrix.');
end
    
DisRawMatrix=all_shortest_paths(AdjMatrixSparse); %�����������̾������
DiaRaw=max(max(DisRawMatrix)); %���������ֱ��

A = full(AdjMatrixSparse);
fprintf('ֱ��: %f\n',DiaRaw)
fprintf('ƽ������: %f\n',sum(sum(DisRawMatrix))/(NumOfNodes^2))
fprintf('ƽ����: %f\n',average_degree(A))
[a,b,c]= clust_coeff(A);
fprintf('ƽ������ϵ��: %f\n',b)

figure(1);
a = tabulate(degrees(A));
x = a(:,1);
y = a(:,3)/100;
plot(x,y)
str1 = ['����N��',num2str(NumOfNodes),',����K��',num2str(length(Edges)/2)];
title(str1)

figure(2);
a = tabulate(degrees(A));
x = a(:,1);
y = a(:,3)/100;
plot(x,log(y))
str1 = ['����N��',num2str(NumOfNodes),',����K��',num2str(length(Edges)/2),'��������ϵ'];
title(str1)