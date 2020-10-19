x = [1 2 4 7 9 12 13 15 17];
f = [1.5 3.9 6 11.7 12.6 18.8 20.3 20.6 21.1];
axis([0 18 1 22])
xlabel('x')
ylabel('f')
y = 1:0.1:17;
figure(1)
plot(x,f,'o')
gtext('��֪���ݵ�')
hold on;pause
bbl=interp1(x,f,y,'nearest') 
% 'nearest'�����ڽ���ֵ�� 'linear'���Բ�ֵ�� 'spline'����������ֵ;
plot(y,bbl)
gtext('����ڲ�ֵ')
hold on;pause
a=polyfit(x,f,3) % �����ζ���ʽ���x,f
aa=polyval(a,y)  % x�����ζ���ʽ�µ�ֵy
plot(y,aa)
gtext('�����������')
hold off;pause

figure(2)
plot(x,f,'o')
gtext('��֪���ݵ�')
hold on;pause
bbl=interp1(x,f,y,'linear') 
% 'nearest'�����ڽ���ֵ�� 'linear'���Բ�ֵ�� 'spline'����������ֵ;
plot(y,bbl)
gtext('���Բ�ֵ')
hold on;pause
a=polyfit(x,f,3) % �����ζ���ʽ���x,f
aa=polyval(a,y)  % x�����ζ���ʽ�µ�ֵy
plot(y,aa)
gtext('�����������')
hold off;pause


figure(3)
plot(x,f,'o')
gtext('��֪���ݵ�')
hold on;pause
bbl=interp1(x,f,y,'spline') 
% 'nearest'�����ڽ���ֵ�� 'linear'���Բ�ֵ�� 'spline'����������ֵ;
plot(y,bbl)
gtext('��������')
hold on;pause
a=polyfit(x,f,3) % �����ζ���ʽ���x,f
aa=polyval(a,y)  % x�����ζ���ʽ�µ�ֵy
plot(y,aa)
gtext('�����������')
hold off;pause