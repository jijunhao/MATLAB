n=500; x=(rand(n,2)*2-1)*10; y=sin(x(:,1)/10*pi);
y2=y.^2; yy=repmat(y2,1,n)+repmat(y2',n,1)-2*y*y';
e=10; h=1; r=exp(-yy/(2*h)); rr=sum(r)'/(n^2); 
t0=randn(2,1); t0=t0/norm(t0); c=pi*h;
for o=1:10000
  z=x*t0; z2=z.^2; zz=repmat(z2,1,n)+repmat(z2',n,1)-2*z*z';
  k=exp(-zz/(2*h)); kz=k.*(repmat(z',[n 1])-repmat(z,[1 n]));
  U=c*exp(-(zz+yy)/(4*h)); v=mean(kz.*r/h,2)-sum(kz,2).*rr/h;
  a=(U+0.1*eye(n))\v; g=(k.*r)*x/n-(k*x).*repmat(rr,[1 2]);
  t=t0+e*g'*a; t=t/norm(t);
  if norm(t-t0)<0.00001, break, end
  t0=t;
end

figure(1); clf; hold on; axis([-10 10 -10 10]); colormap gray
scatter3(x(:,1),x(:,2),y,100,y,'filled'); colorbar;
plot(99*[-t(1) t(1)],99*[-t(2) t(2)],'k-');
