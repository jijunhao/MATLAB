clear
X1=[81.2;82.9;83.2;85.9;88.0;99.0;102.0;105.3;117.7;126.4;131.2;148.0;153.0;161.0;170.0;170.0;185.0;189.0];
X2=[85.0;92.0;91.5;92.9;93.0;96.0;95.0;95.6;98.9;101.5;102;105;106;109;112;112.5;113;114];
X3=[87;94;95;95.5;96;97;97.5;98;101.2;102.5;104;105.9;109.5;111;111.5;112;112.3;113];
Y=[7.8;8.4;8.7;9.0;9.6;10.3;10.6;10.9;11.3;12.3;13.5;14.2;14.9;15.9;18.5;19.5;19.9;20.5];
n=length(X1);
p=3;
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
    m = size(A1);    
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
        B(k,:)=[k,RMSq,Cp,AIC,RSSq];
    end
end
D= round(B,4);
T=table(D(:,1),D(:,2),D(:,3),D(:,4),D(:,5),var,...
    'VariableNames',{'k','RMSq','Cp','AIC','RSSq','Var'});
sortrows(T,'RMSq')
sortrows(T,'Cp')
sortrows(T,'AIC')