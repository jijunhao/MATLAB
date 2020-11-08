n = 13;
A = zeros(n);
A(1,[2,3,4,5,6])=1;A(2,[3,6,7,8])=1;A(3,[4,9,10])=1;
A(4,[5,10,11])=1;A(5,[6,12,13])=1;A(6,[7,13])=1;
A(9,10)=1;A(11,12)=1;
A = A+A';

[X,B]=eig(A);
[lamda,id] = max(max(B));
cev = zeros(1,n);
for i=1:n
    cev(i)=abs(1/lamda*A(i,:)*X(:,id));
end
cev