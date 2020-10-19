n=100000; r=0.5; s=sqrt(1-r^2); t=zeros(2,n);
for i=2:n
  t(1,i)=s*randn+r*t(2,i-1); t(2,i)=s*randn+r*t(1,i);
end

figure(1); clf; hold on
u1=repmat(t(1,:),[2,1]); u1=u1(:);
u2=repmat(t(2,:),[2,1]); u2=u2(:);
plot(u1([2:200 200]),u2(1:200),'b-');

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
  P(X,Y)=exp(-(a(X)^2-2*r*a(X)*a(Y)+a(Y)^2)/2/s)/(2*pi*s);
end, end
surf(a,a,P');
