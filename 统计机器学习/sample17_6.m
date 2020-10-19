n=12; mu=0.5; x=randn(n,1)+mu;
bs=[0.01:0.01:3]; bl=length(bs);
MLE=mean(x);
for i=1:bl
  bb=bs(i)^(-2); MAP(i)=sum(x)/(n+bb);
  logML(i)=-n/2*log(2*pi)-sum((x-MAP(i)).^2)/2 ...
           -MAP(i)^2/(2*bb)-log(n*bb+1);
end
[dummy,c]=max(logML);

figure(1); clf; hold on;
plot(bs,logML,'r-');
plot(bs(c),logML(c),'ro');
xlabel('\beta'); legend('log ML',4);

figure(2); clf; hold on;
plot(bs,mu*ones(1,bl),'k:','LineWidth',5);
plot(bs,MAP,'r-','LineWidth',2);
plot(bs,MLE*ones(1,bl),'b-.','LineWidth',2);
plot(bs(c),MAP(c),'ro','LineWidth',4,'MarkerSize',10);
xlabel('\beta'); ylabel('\mu');
legend('True','MAP','MLE',4);
