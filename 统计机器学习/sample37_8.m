n=500; a=linspace(0,2*pi,n/2)'; y=[ones(1,n/2) zeros(1,n/2)];
x=[a.*cos(a) a.*sin(a); (a+pi).*cos(a) (a+pi).*sin(a)];
x=x+rand(n,2); x=x-repmat(mean(x),[n,1]); x2=sum(x.^2,2);
d=repmat(x2,1,n)+repmat(x2',n,1)-2*x*x'; 

hs=[0.5 1 2].^2; ls=10.^[-5 -4 -3]; m=2; r=size(x,2)/2;
u=mod(randperm(n),m)+1; hhs=2*[0.5 1 2].^2; 
g=zeros(length(hhs),length(ls),m);

for hk=1:length(hs)
  h=hs(hk); k=exp(-d/(2*h));
  for j=unique(y)
    t=(y==j); U=(pi*h)^r*exp(-d(t,t)/(4*h));
    for i=1:m
      ai=(u~=i); ni=sum(a); aj=(u==i); nj=sum(aj);
      vi=sum(k(t,ai&t),2)/ni-sum(k(t,ai),2)*sum(ai&t)/(ni^2);
      vj=sum(k(t,aj&t),2)/nj-sum(k(t,aj),2)*sum(aj&t)/(nj^2);
      for lk=1:length(ls)
        l=ls(lk); a=(U+l*eye(sum(t)))\vi;
        g(hk,lk,i)=g(hk,lk,i)+a'*U*a-2*vj'*a;
end, end, end, end
g=mean(g,3); [gl,ggl]=min(g,[],2); [ghl,gghl]=min(gl); 
L=ls(ggl(gghl)); H=hs(gghl); s=0;
for j=unique(y)
  t=(y==j); ny=sum(t); U=(pi*H)^r*exp(-d(t,t)/(4*H));
  k=exp(-d(t,:)/(2*H)); v=sum(k(:,t),2)/n-sum(k,2)*ny/(n^2);
  a=(U+L*eye(ny))\v; s=s+v'*a;
end
disp(sprintf('Information=%g',s));
