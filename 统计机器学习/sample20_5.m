x=[2*randn(1,100)-5 randn(1,50); randn(1,100) randn(1,50)+3];
[d,n]=size(x); m=5; z=mod(randperm(n),m)+1;
a0=1; b0=1; n0=1; W0=eye(d);
for o=1:100
  for i=1:n
    g=(1:n~=i); X=x(:,g); Z=z(g);
    for k=1:m
      p(k)=0; e=(Z==k); t=sum(e);
      if t~=0
        u=n0+t-d+1; b=b0+t; c=sum(X(:,e),2); xi=x(:,i)-c/t; 
        W=inv((b+1)/b/u*(W0+X(:,e)*X(:,e)'-c*c'/b));
        p(k)=(a0+t-1)*gamma((u+d)/2)/gamma(u/2)*u^(-d/2) ...
             *sqrt(det(W))*(1+xi'*W*xi/u)^(-(u+d)/2);
    end, end
    z(i)=find(cumsum(p/sum(p))>rand,1);
end, end

figure(1); clf; hold on
plot(x(1,:),x(2,:),'ro'); v=linspace(0,2*pi,100);
for k=1:m
  e=(z==k); t=sum(e); nu(k)=n0+t; u=nu(k)-d+1; b=b0+t;
  c=sum(x(:,e),2); w(k)=a0+t; h(:,k)=c/b; W(:,:,k)=zeros(d);
  if t~=0
    W(:,:,k)=inv((W0+x(:,e)*x(:,e)'-c*c'/b));
  end
end
w=w./sum(w);
for k=1:m
  [V,D]=eig(nu(k)*W(:,:,k));
  X=3*w(k)*V'*[cos(v)/D(1,1); sin(v)/D(2,2)];
  plot(h(1,k)+X(1,:),h(2,k)+X(2,:),'b-')
end
