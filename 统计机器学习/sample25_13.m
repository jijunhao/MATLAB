n=50; x=linspace(-3,3,n)'; pix=pi*x;
y=sin(pix)./(pix)+0.1*x+0.2*randn(n,1); y(n/2)=-0.5;
hh=2*0.3^2; l=0.1; e=0.1; t=randn(n,1); x2=x.^2;
k=exp(-(repmat(x2,1,n)+repmat(x2',n,1)-2*x*x')/hh);
for o=1:1000
  r=abs(k*t-y); w=ones(n,1); w(r>e)=e./r(r>e);
  Z=k*(repmat(w,1,n).*k)+l*pinv(diag(abs(t)));
  t0=(Z+0.000001*eye(n))\(k*(w.*y));
  if norm(t-t0)<0.001, break, end
  t=t0;
end
N=1000; X=linspace(-3,3,N)';
K=exp(-(repmat(X.^2,1,n)+repmat(x2',N,1)-2*X*x')/hh); F=K*t;
figure(1); clf; hold on; axis([-2.8 2.8 -1 1.5]);
plot(X,F,'g-'); plot(x,y,'bo'); 
