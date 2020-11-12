clear
X1=[149;161;171;175;180;190;202;212;226;231;239];
X2=[4.2;4.1;3.1;3.1;1.1;2.2;2.1;5.6;5;5.1;0.7];
X3=[108;114;123;126;132;137;146;154;162;164;167];
Y=[16;16;19;19;19;20;23;27;28;28;26];
n=11; p=3; 
M=1:p;
I=ones(n,1);
X=[X1,X2,X3];
beta=inv([I,X]'*[I,X])* [I,X]'*Y;
Ycap=[I,X]*beta;
RSSp=(Y-Ycap)'*(Y-Ycap);
k=0;
syms x1 x2 x3;
XZ= [x1; x2; x3];
var = [];
for q=1:p
    A=nchoosek(M,q);
    a=nchoosek(p,q);
    A1=nchoosek(XZ,q);
    [m,n] = size(A1);
    for i=1:m
        var= [var;strjoin(string(A1(i,:)),', ')];
    end
    for j=1:a
        Xq=[I,X(:,A(j,:))];
        beta=inv(Xq'*Xq)*Xq'*Y;
        Ycap=Xq*beta;
        RSSq=(Y-Ycap)'*(Y-Ycap);
        RMSq=RSSq/(n-(q+1));
        Cp=(n-p-1)*RSSq/RSSp-(n-2*q-2);
        AIC=n*log(RSSq)+2*q+2;
        k=k+1;
        B(k,:)=[k, RMSq,Cp,AIC,RSSq];
     end
     end
D= round(B,4);
T=table(D(:,1),D(:,2),D(:,3),D(:,4),D(:,5),var,...
        'VariableNames',{'k','RMSq','Cp','AIC','RSSq','Variables'});
sortrows(T,'AIC')