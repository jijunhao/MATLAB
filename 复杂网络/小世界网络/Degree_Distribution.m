clc;
a = tabulate(degrees(A));
x = a(:,1);
y = a(:,2)/length(A);
plot(x,y)