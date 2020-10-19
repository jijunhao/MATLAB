n=10000000; s=3; x=randn(n,1)*s; x2=x.^2; ss=2*s^2;
t=mean(x2.*(exp(-abs(x))/2)./(exp(-x2./ss)/sqrt(ss*pi)))
