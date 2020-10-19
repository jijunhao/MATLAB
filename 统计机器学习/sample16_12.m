n=500; x=myrand(n); x2=x.^2; hs=[0.01 0.1 0.5]; t=5; 
d2=repmat(x2,[n 1])+repmat(x2',[1 n])-2*x'*x;
v=mod(randperm(n),t)+1;
for i=1:length(hs)
  hh=2*hs(i)^2; P=exp(-d2/hh)/sqrt(pi*hh);
  for j=1:t      
    s(j,i)=mean(log(mean(P(v~=j,v==j))));
  end
end
[dum,a]=max(mean(s)); h=hs(a); hh=2*h^2;
ph=mean(exp(-d2/hh)/(sqrt(pi*hh)));
figure(1); clf; plot(x,ph,'r*'); h
