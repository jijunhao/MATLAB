n=12; mu=0.5; x=randn(n,1)+mu;
bs=[0.01:0.01:3]; bl=length(bs);
MLE=mean(x);
for i=1:bl
  MAP(i)=sum(x)/(n+bs(i).^(-2));
end

figure(1); clf; hold on;
plot(bs,mu*ones(1,bl),'k:');
plot(bs,MAP,'r-');
plot(bs,MLE*ones(1,bl),'b-.');
xlabel('\beta'); ylabel('\mu');
legend('True','MAP','MLE',4);
