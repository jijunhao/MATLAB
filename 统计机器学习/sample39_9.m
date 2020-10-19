Tp=[2 0 1; 0 2 0; 1 0 2]; Tq=[2 0 0; 0 2 0; 0 0 2];
Tp=[2 1 0; 1 2 1; 0 1 2]; Tq=[2 0 1; 0 2 1; 1 1 2];
d=3; n=50; xp=Tp^(-1/2)*randn(d,n); Sp=xp*xp'/n;
xq=Tq^(-1/2)*randn(d,n); A0=eye(d); C=1; e=0.1;
for o=1:1000000
  U=exp(sum((A0*xq).*xq));
  A=A0-e*((repmat(U,[d 1]).*xq)*xq'/sum(U)-Sp);
  A(:)=L1BallProjection(A(:),C);
  if norm(A-A0)<0.00000001, break, end
  A0=A;
end
-2*A, Tp-Tq
