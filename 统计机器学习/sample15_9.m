x=[2*randn(1,100)-5 randn(1,50); randn(1,100) randn(1,50)+3];
[d,n]=size(x); m=5; e=rand(n,m); S=zeros(d,d,m);
for o=1:10000
  e=e./repmat(sum(e,2),[1 m]); g=sum(e); w=g/n;
  mu=(x*e)./repmat(g,[d 1]); 
  for k=1:m
    t=x-repmat(mu(:,k),[1 n]);
    S(:,:,k)=(t.*repmat(e(:,k)',[d 1]))*t'/g(k);
    e(:,k)=w(k)*det(S(:,:,k))^(-1/2) ...
           *exp(-sum(t.*(S(:,:,k)\t))/2);
  end
  if o>1 && norm(w-w0)+norm(mu-mu0)+norm(S(:)-S0(:))<0.001
    break
  end
  w0=w; mu0=mu; S0=S;
end

figure(1); clf; hold on
plot(x(1,:),x(2,:),'ro'); v=linspace(0,2*pi,100);
for k=1:m
  [V,D]=eig(S(:,:,k));
  X=3*w(k)*V'*[cos(v)*D(1,1); sin(v)*D(2,2)];
  plot(mu(1,k)+X(1,:),mu(2,k)+X(2,:),'b-')
end
