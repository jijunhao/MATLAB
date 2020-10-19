d1=20; d2=10; n=100; K=(reshape(randperm(d1*d2),[d1,d2])<=n);
r=3; X=randn(d1,r)*randn(r,d2); T0=randn(d1,d2); e=0.1; l=1;
for o=1:1000
  [U,S,V]=svd(T0-e*((T0.*K)-(X.*K)),'econ');
  S=diag(max(0,diag(S)-e*l)); T=U*S*V';
  if norm(T-T0)<0.001, break, end
  T0=T;
end
figure(1); imagesc(X.*K); figure(2); imagesc(T);
