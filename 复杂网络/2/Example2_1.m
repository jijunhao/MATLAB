A=[0 1 1 0 1 0;1 0 1 1 0 0;1 1 0 0 0 1;0 1 0 0 0 1;1 0 0 0 0 0;0 0 1 1 0 0];
D=all_shortest_paths(sparse(A));
C=clustering_coefficients(sparse(A));
