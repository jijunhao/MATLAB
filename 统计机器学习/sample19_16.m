n=100000; t=zeros(2,n);
for i=2:n
  u=randn(2,1)+t(:,i-1);
  if rand<=pdf(u)/pdf(t(:,i-1))
    t(:,i)=u;
  else
    t(:,i)=t(:,i-1);
  end
end

figure(1); clf; hold on
plot(t(1,1:500),t(2,1:500),'b-');

figure(2); clf; hold on
c=4; m=30; Q=zeros(m,m);
a=linspace(-c,c,m); b=-c+2*c/m*[1:m];
for k=1:n
  x=find(ceil(t(1,k)-b)==0,1);
  y=find(ceil(t(2,k)-b)==0,1);
  Q(x,y)=Q(x,y)+1;
end
surf(a,a,Q'/(2*c/m)^2/n);

figure(3); clf; hold on
P=zeros(m,m); 
for X=1:m, for Y=1:m
  P(X,Y)=pdf([a(X);a(Y)]);
end, end
surf(a,a,P');
