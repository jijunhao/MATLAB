n=9;
a=zeros(n);
a(1,[2,3])=1;a(2,3)=1;a(3,[4,6])=1;
a(4,5)=1;a(5,[7,8,9])=1;
a(6,7)=1;a(8,9)=1;
A=a+a';
imcv = zeros(1,n);
for i=1:n
    A_ = A;
    col=find(A(i,:)==1);
    for j=1:length(col)
        A_(i,:) = bitor(A_(i,:)==1,A(col(j),:)==1);
        A_(:,i) = bitor(A_(:,i)==1,A(:,col(j))==1);
    end
    A_(i,i)=0;
    A_(col,:) = [];
    A_(:,col) = []; 
    imcv(i) = 1 - (ave_path_length(A_)*(n-length(col)))/(ave_path_length(A)*n);
end
imcv