clear
A = xlsread('3.16.xlsx');
X1=A(:,1);
X2=A(:,2);
Y=A(:,3);
II=ones(length(A),1);
X=[II,X1,X2];
j=1;
for L=-10:10;
     Lam=L/10;
 if Lam==0;
    Ylam=log(Y);
else
    Ylam=(Y.^(Lam) -1)/Lam;
 end; 
Ja=geomean(Y.^(Lam-1));
Z=Ylam/Ja;
Beta=inv(X'*X)*X'*Z; 
Zcap=X*Beta;
RSS3(j)=(Z-Zcap)'*(Z-Zcap);
j=j+1; 
end
Lambda=-1:0.1:1;
plot(Lambda,RSS3);
[Lambda',RSS3']