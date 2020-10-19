n=2; T=6; y=[ones(n/2,T); -ones(n/2,T)];
x=[randn(2,n,T); ones(1,n,T)]; r(1,1,:)=pi*[1:T]/T/10;
c=repmat(cos(r),[1 n/2]); x(1,:,:)=x(1,:,:)+[c -c];
s=repmat(sin(r),[1 n/2]); x(2,:,:)=x(2,:,:)+[s -s];
t0=randn(3,T); e=0.1; l=4;
for o=1:1000
  for k=1:T
    gt(:,k)=x(:,:,k)*(x(:,:,k)'*t0(:,k)-y(:,k));
  end      
  [U,S,V]=svd(t0-e*gt,'econ');
  S=diag(max(0,diag(S)-e*l)); t=U*S*V';
  if norm(t-t0)<0.001, break, end
  t0=t;
end

figure(1); clf; colormap([1 0.7 1; 0.7 1 1]); 
m=20; X=linspace(-4,4,m); b=repmat(X,[m 1]); bt=b';
for k=1:T
  Y=t(:,k)'*[b(:)'; bt(:)'; ones(1,m^2)];
  subplot(2,3,k); hold on; contourf(X,X,reshape(Y,m,m));
  plot(x(1,y(:,k)==1,k),x(2,y(:,k)==1,k),'bo');
  plot(x(1,y(:,k)==-1,k),x(2,y(:,k)==-1,k),'rx');
  plot(99*sin(r(k))*[1 -1],99*cos(r(k))*[-1 1],'k--');
  axis([-4 4 -4 4]);
end
