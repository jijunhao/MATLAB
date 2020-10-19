m=101;
x=-5:10/(m-1):5;
y=1./(1+x.^2);z=0*x;
plot(x,z,'r',x,y,'LineWidth',1.5)

for n=3:10
    x0=-5:10/(n-1):5;
    y0=1./(1+x0.^2);
    y1=lagrl(x0,y0,x);
    hold on,plot(x,y1,'b')
end

