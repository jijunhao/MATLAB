A=[0 1 1 0 1 0;1 0 1 1 0 0;1 1 0 0 0 1;0 1 0 0 0 1;1 0 0 0 0 0;0 0 1 1 0 0];
a=degrees(sparse(A));
K=full(a);
average_K=average_degree(A);
[B,E]=betweenness_centrality(sparse(A)); %betweenness_centrality for directed graph, so the node betweenness =B/2 for undirected graph; the edge betweenness = E-1. 
C=core_numbers(sparse(A));

%%
% %Figure2.9(a)
% Edgelist=[2 1 1;2 3 1;3 6 1;4 6 1;5 6 1;6 7 1;7 8 1;8 9 1;8 11 1;8 12 1;9 10 1;13 12 1];
% A=edgeL2adj(Edgelist);
% [B,E]=betweenness_centrality(sparse(A));
% 
% %Figure2.9(b)
% Edgelist=[2 1 1;2 3 1;3 6 1;4 6 1;5 6 1;6 7 1;7 8 1;8 9 1;7 10 1;7 11 1;12 11 1];
% A=edgeL2adj(Edgelist);
% [B,E]=betweenness_centrality(sparse(A));