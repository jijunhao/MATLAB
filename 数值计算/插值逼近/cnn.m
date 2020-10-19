x = [1 2 4 7 9 12 13 15 17];
f = [1.5 3.9 6 11.7 12.6 18.8 20.3 20.6 21.1];
axis([0 18 1 22])
xlabel('x')
ylabel('f')
y = 1:0.1:17;
figure(1)
plot(x,f,'o')
gtext('已知数据点')
hold on;pause
bbl=interp1(x,f,y,'nearest') 
% 'nearest'是最邻近插值， 'linear'线性插值； 'spline'三次样条插值;
plot(y,bbl)
gtext('最近邻插值')
hold on;pause
a=polyfit(x,f,3) % 用三次多项式拟合x,f
aa=polyval(a,y)  % x在三次多项式下的值y
plot(y,aa)
gtext('三次曲线拟合')
hold off;pause

figure(2)
plot(x,f,'o')
gtext('已知数据点')
hold on;pause
bbl=interp1(x,f,y,'linear') 
% 'nearest'是最邻近插值， 'linear'线性插值； 'spline'三次样条插值;
plot(y,bbl)
gtext('线性插值')
hold on;pause
a=polyfit(x,f,3) % 用三次多项式拟合x,f
aa=polyval(a,y)  % x在三次多项式下的值y
plot(y,aa)
gtext('三次曲线拟合')
hold off;pause


figure(3)
plot(x,f,'o')
gtext('已知数据点')
hold on;pause
bbl=interp1(x,f,y,'spline') 
% 'nearest'是最邻近插值， 'linear'线性插值； 'spline'三次样条插值;
plot(y,bbl)
gtext('三次样条')
hold on;pause
a=polyfit(x,f,3) % 用三次多项式拟合x,f
aa=polyval(a,y)  % x在三次多项式下的值y
plot(y,aa)
gtext('三次曲线拟合')
hold off;pause