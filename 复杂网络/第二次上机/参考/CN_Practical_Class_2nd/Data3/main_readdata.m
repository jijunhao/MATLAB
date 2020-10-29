%��ԭʼ�����ж�ȡ����
tic;
fid=fopen('./power/power.gml'); %��ԭʼ�����ж�ȡ����
tline=fgetl(fid);
while ~strcmp(strtrim(tline),'edge')  %һֱ��ȡ����һ�С�edge��Ϊֹ
    tline=fgetl(fid);
end
num_edge=0;
while ~feof(fid)
    tline=fgetl(fid); %��һ��Ϊ��[��
    
    tline1=fgetl(fid); %��һ��Ϊ��source ����ͷ��
    trim_tline1=strtrim(tline1);%ȥ���ַ�����β����Ŀո�
    S1=regexp(trim_tline1, ' ', 'split'); %���м���Ǹ��ո�ȥ��������ַ��������Եõ�Դ�ڵ�ı��
    num_edge=num_edge+1;
    Edges(num_edge,1)=eval(S1{2});  %��cell���͵�����ת��Ϊ��ֵ��ʽ��EdgesΪһ�����еľ���ÿһ�д���һ����
    
    tline2=fgetl(fid); %��һ��Ϊ��target ����ͷ��
    trim_tline2=strtrim(tline2);%ȥ���ַ�����β����Ŀո�
    S2=regexp(trim_tline2, ' ', 'split'); %���м���Ǹ��ո�ȥ��������ַ��������Եõ�Ŀ��ڵ�ı��
    Edges(num_edge,2)=eval(S2{2});  %��cell���͵�����ת��Ϊ��ֵ��ʽ
    
    tline=fgetl(fid); %��һ��Ϊ��]��
    tline=fgetl(fid); %��һ��Ϊ��edge��
end
fclose(fid);
csvwrite('USpower.dat',Edges);

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

% %%
% %�����ҵ����ԭʼ����������ͨ��ͼ
% LB=largest_component(AdjMatrixSparse); %�����ͨ��ͼ��ϡ�������ʽLB������ʱ�ı����������
% [r_index,c_index,value]=find(LB);%����ȡ�����ͨ��ͼϡ����������Ԫ��
% AdjMatrixLargestCom=[r_index,c_index];
% dm_DC=max(r_index);%��ΪLB��ָ���������仯�ģ�����dm_DC���������ͨ��ͼLB�Ľڵ����
% num_edg=size(r_index,1);

% DisLargestComMatrix=all_shortest_paths(LB); %�����ͨ���������̾������
% DiaLargestCom=max(max(DisLargestComMatrix)); %�����ͨ�������ֱ����

%%
%���ݵĴ洢
dlmwrite('SparseAdjMatrix.dat',Edges,'precision','%.0f');
dlmwrite('V.dat',NumOfNodes,'precision','%.0f');
dlmwrite('Diameter.dat',DiaRaw,'precision','%.0f');

ElapsedTime=toc;
csvwrite('ElapsedTime.dat',ElapsedTime);