n=500; x=myrand(n); x2=x.^2;
ks=[10 50 100]; t=5; g=gamma(3/2);
d2=repmat(x2,[n 1])+repmat(x2',[1 n])-2*x'*x;
v=mod(randperm(n),t)+1;
for j=1:t
  S=sort(d2(v~=j,v==j));
  for i=1:length(ks)
    k=ks(i); r=sqrt(S(k+1,:));
    s(j,i)=mean(log(k*g./(sum(v~=j)*sqrt(pi)*r)));
  end
end
[dum,a]=max(mean(s)); k=ks(a);
m=1000; X=linspace(0,5,m); 
D2=repmat(X.^2,[n 1])+repmat(x2',[1 m])-2*x'*X;
S=sort(D2); r=sqrt(S(k+1,:))'; Ph=k*g./(n*sqrt(pi)*r);
figure(1); clf; plot(X,Ph,'r*'); k
