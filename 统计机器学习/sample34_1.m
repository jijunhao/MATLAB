n=2; T=6; y=[ones(n/2,T); -ones(n/2,T)];
x=[randn(2,n,T); ones(1,n,T)]; r(1,1,:)=pi*[1:T]/T/10;
c=repmat(cos(r),[1 n/2]); x(1,:,:)=x(1,:,:)+[c -c];
s=repmat(sin(r),[1 n/2]); x(2,:,:)=x(2,:,:)+[s -s];
Ci=inv(-ones(T,T)+diag(T*ones(T,1)+0.01));
a=repmat([1:T],[n 1]); a=a(:); m=20; X=linspace(-4,4,m); 
b=repmat(X,[m 1]); bt=b'; XX=[b(:)'; bt(:)'; ones(1,m^2)];
yAi=y(:)'*inv(Ci(a,a).*(x(:,:)'*x(:,:))+eye(n*T));

figure(1); clf; colormap([1 0.7 1; 0.7 1 1]); 
for k=1:T
%  Y=yAi*(repmat(Ci(a,k),[1 3]).*x(:,:)')*XX;
  q=x(:,:,k); Y=((q*q'+0.01*eye(3))\(q*y(:,k)))'*XX;
  subplot(2,3,k); hold on; contourf(X,X,reshape(Y,m,m));
  plot(x(1,y(:,k)==1,k),x(2,y(:,k)==1,k),'bo');
  plot(x(1,y(:,k)==-1,k),x(2,y(:,k)==-1,k),'rx');
  plot(99*sin(r(k))*[1 -1],99*cos(r(k))*[-1 1],'k--');
  axis([-4 4 -4 4]);
end
