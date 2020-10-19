function a=KLIEP(k,r)
a0=rand(size(k,2),1); b=mean(r)'; n=size(k,1);
for o=1:10000
  a=a0-0.001*(b-k'*(1./(k*a0))/n); %a=max(0,a);
  if norm(a-a0)<0.001, break, end
  a0=a;
end
