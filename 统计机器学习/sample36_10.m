load digit.mat; x=X(:,1:100,2); [d,n]=size(x); g=min(x,[],2);
x=(x-repmat(g,1,n))./repmat(max(x,[],2)-g,1,n); x=(x>0.5);
m=10; e=0.01/n; W0=randn(m,d); b0=randn(d,1); c0=rand(m,1); 
for o=1:100000
  Z=1./(1+exp(-W0*x-repmat(c0,[1 n])));
  Y=1./(1+exp(-W0'*Z-repmat(b0,[1 n])));
  nb=Y-x; % Cross entropy loss
%  nb=(Y-x).*Y.*(1-Y); % Squared loss
  nc=(W0*nb).*Z.*(1-Z); W=W0-e*(Z*nb'+nc*x');
  b=b0-e*sum(nb,2); c=c0-e*sum(nc,2);
  if norm(W-W0)+norm(b-b0)+norm(c-c0)<0.003, break, end
  W0=W; b0=b; c0=c;
end
t=T(:,1,2)>0.5; u=t; u(rand(d,1)>0.9)=1; u(rand(d,1)>0.9)=0;
z=1./(1+exp(-W*t-c)); y=1./(1+exp(-W'*z-b));

figure(1); clf; hold on; colormap gray
subplot(1,3,1); imagesc(reshape(t,[16 16])')
subplot(1,3,2); imagesc(reshape(u,[16 16])')
subplot(1,3,3); imagesc(reshape(y>0.5,[16 16])')
