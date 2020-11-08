n = 13;
A = zeros(n);
A(1,[2,3,4,5,6])=1;A(2,[3,6,7,8])=1;A(3,[4,9,10])=1;
A(4,[5,10,11])=1;A(5,[6,12,13])=1;A(6,[7,13])=1;
A(9,10)=1;A(11,12)=1;
A = A+A';

cnv = ones(n,1);
D = diameter(A);
for i=1:D-1
    cav = A*cnv;
    cav = cav/sum(cav);
    cnv =cav;
end
cav'
