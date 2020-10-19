n=50; N=1000; x=linspace(-3,3,n)'; pix=pi*x;
y=sin(pix)./(pix)+0.1*x+0.05*randn(n,1);

x(:,2)=1; d=1; m=20; e=0.1; a=ones(m,1); b=randn(m,d+1);
for o=1:n*100000
  i=ceil(rand*n); z=1./(1+exp(-b*x(i,:)')); r=y(i)-a'*z; 
  a0=a+e*z*r; b0=b+e*(a.*z.*(1-z)*x(i,:))*r;
  if norm(a-a0)+norm(b-b0)<0.00000001, break, end
  a=a0; b=b0;
end

X=linspace(-3,3,N)'; X(:,2)=1; Y=a'*(1./(1+exp(-b*X')));
figure(1); clf; hold on; axis([-2.8 2.8 -0.5 1.2]);
plot(X(:,1),Y,'g-'); plot(x(:,1),y,'bo'); 
