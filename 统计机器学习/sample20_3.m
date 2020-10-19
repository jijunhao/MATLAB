x=[2*randn(1,100)-5 randn(1,50); randn(1,100) randn(1,50)+3];
[d,n]=size(x); m=5; e=rand(n,m); W=zeros(d,d,m); b0=1;
for o=1:10000
  e=e./repmat(sum(e,2),[1 m]); 
  g=sum(e); a=1+g; b=b0+g; nu=3+g; w=a/sum(a);
  xe=x*e; c=xe./repmat(g,[d 1]); h=xe./repmat(b,[d 1]); 
  for k=1:m
    t1=x-repmat(c(:,k),[1 n]); t2=x-repmat(h(:,k),[1 n]);
    W(:,:,k)=inv(eye(d)+(t1.*repmat(e(:,k)',[d 1]))*t1' ...
                 +c(:,k)*c(:,k)'*b0*g(k)/(b0+g(k)));
    t3=sum(psi((nu(k)+1-[1:d])/2))+log(det(W(:,:,k)));
    e(:,k)=exp(t3/2+psi(a(k))-psi(sum(a))-d/2/b(k) ...
               -sum(t2.*(W(:,:,k)*t2))*nu(k)/2);
  end
  if o>1 && norm(w-w0)+norm(h-h0)+norm(W(:)-W0(:))<0.001
    break
  end
  w0=w; h0=h; W0=W;
end

figure(1); clf; hold on
plot(x(1,:),x(2,:),'ro'); v=linspace(0,2*pi,100);
for k=1:m
  [V,D]=eig(nu(k)*W(:,:,k));
  X=3*w(k)*V'*[cos(v)/D(1,1); sin(v)/D(2,2)];
  plot(h(1,k)+X(1,:),h(2,k)+X(2,:),'b-')
end
