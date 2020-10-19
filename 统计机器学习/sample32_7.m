u=17; z(1:u+1,1)=1.2; n=200; d=20; N=n+130; 
for t=u+1:u+N+d
  z(t+1)=0.9*z(t)+0.2*z(t-u)/(1+z(t-u)^10);
end
z=z(u+1:u+N+d); Y=z(d+1:end); x0=zeros(n+d-1,d);
%z=z+0.1*randn(N+d,1);
for i=1:d
  x0(i:n+d-1,i)=z(1:n+d-i);
end
x0=x0(d:end,:); y0=z(d+1:n+d);

B=100; v=zeros(N-n+d,B);
for s=1:B
  r=ceil(n*rand(n,1)); x=x0(r,:); y=y0(r);
  x2=sum(x.^2,2); xx=repmat(x2,1,n)+repmat(x2',n,1)-2*x*x';
  hhs=median(xx(:))*2*[0.5,0.2:1.5].^2; ls=[0.01 0.1 1 10];
  m=5; u=mod(randperm(n),m)+1;
  for hk=1:length(hhs)
    hh=hhs(hk); k=exp(-xx/hh);
    for i=1:m
      ki=k(u~=i,:); kc=k(u==i,:); yi=y(u~=i); yc=y(u==i);
      for lk=1:length(ls)
        t=(ki'*ki+ls(lk)*eye(n))\(ki'*yi);
        g(hk,lk,i)=mean((yc-kc*t).^2);
  end, end, end
  [gl,ggl]=min(mean(g,3),[],2); [ghl,gghl]=min(gl); 
  L=ls(ggl(gghl)); HH=hhs(gghl); k=exp(-xx/HH);
  t=(k^2+L*eye(n))\(k*y); v(:,s)=[y0(n-d+1:n); zeros(N-n,1)];
  for i=1:N-n
    X=fliplr(v(i:d+i-1,s)');
    K=exp(-(repmat(sum(X.^2),1,n)+x2'-2*X*x')/HH);
    v(d+i,s)=K*t;
end, end

figure(1); clf; hold on; a=mean(v(d+1:end,:),2);
errorbar([n+1:N],a,std(v(d+1:end,:),0,2),'y-');
plot([1:N],Y,'r--'); plot([n+1:N],a,'g-');
plot([1:n],y0,'ko'); legend('','True','Estimated','Sample',4)
