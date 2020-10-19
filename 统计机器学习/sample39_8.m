TT=[2 0 1; 0 2 0; 1 0 2];
%TT=[2 0 0; 0 2 0; 0 0 2];
%TT=[2 1 0; 1 2 1; 0 1 2];
%TT=[2 0 1; 0 2 1; 1 1 2];
d=3; n=50; x=TT^(-1/2)*randn(d,n); S=x*x'/n;
T0=eye(d); C=5; e=0.1;
for o=1:100000
  T=T0+e*(inv(T0)-S);
  T(:)=L1BallProjection(T(:),C);
  if norm(T-T0)<0.00000001, break, end
  T0=T;
end
T, TT
