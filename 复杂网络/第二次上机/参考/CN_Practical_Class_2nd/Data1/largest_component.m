function adj_matrix=largest_component(A)
%largest_component.m This program is used to find the largest connected
%component.
B=sparse(A);  %A denotes the adjacent matrix of the random network.
[ci,s]=components(B);
[large_num_node,large_index]=max(s);
ss=find(ci==large_index);
adj_matrix=A(ss,ss);   % AA denotes the adjacent matrix of the largest connected component of the Random network