n=100; u=randn(n,1)/4+2; x=randn(n,1)/2+1;
w=2*exp(-8*(x-2).^2+2*(x-1).^2); %w=ones(n,1);

y=sin(pi*x)./(pi*x)+0.1*randn(n,1);
x(:,2)=1; t=(x'*(repmat(w,1,2).*x))\(x'*(w.*y));
X=linspace(-1,3,100); Y=sin(pi*X)./(pi*X);
u(:,2)=1; v=u*t;
figure(1); clf; hold on; 
plot(x(:,1),y,'bo'); plot(X,Y,'r-'); plot(u(:,1),v,'kx');
