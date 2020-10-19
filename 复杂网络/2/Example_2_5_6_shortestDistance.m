Edgelist=[2 1 1;3 2 1;1 3 1;3 4 1;4 5 1];
A=edgeL2adj(Edgelist);
[d,pre]=dijkstra_sp(sparse(A),1);
[d,p]=dijkstra(sparse(A),1,5);
D=all_shortest_paths(sparse(A));
