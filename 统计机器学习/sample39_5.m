N=300; k=5; n=10; m=N-k+1; E=nan(1,N);
y=zeros(1,N); y(101:200)=3; y=y+randn(1,N);
%y=sin([1:N]/2); y(101:200)=sin([101:200]);
x=toeplitz(y); x=x(1:k,1:m); x2=sum(x.^2); 
D=sqrt(repmat(x2',1,m)+repmat(x2,m,1)-2*x'*x); 
for t=n:N-n-k+1
  a=[t-n+1:t]; b=[t+1:t+n];
  E(t)=2*mean(mean(D(a,b)))-mean(mean(D(a,a))) ...
       -mean(mean(D(b,b)));
end

figure(1); clf; hold on; plot(y,'b-'); plot(E,'r--');
legend('Time series','Energy distance')
