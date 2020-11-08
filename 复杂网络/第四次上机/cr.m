n = 10;
A=zeros(n);
A(1,3)=1;A(2,3)=1;A(3,4)=1;
A(4,[5 7])=1;A(5,6)=1;
A(6,7)=1;A(7,8)=1;
A(8,[9 10])=1;
A = A+A';

crv = zeros(1,n);
tlv = zeros(1,n);
for i=1:n
    A_ = A;
    A_(i,:)=0;
    A_(:,i)=0;
    for j=1:n-1
        for k=j+1:n
            if dijkstra(A_,j,k)==Inf
                tlv(i) = tlv(i)+ 1/dijkstra(A,j,k);
            end
        end
    end
    crv(i) = 4*tlv(i)/((n-1)*(n+2));
end
crv