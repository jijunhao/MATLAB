function I_A_B = mutual_information(M)%M±Ì æªÏ¬“æÿ’Û
[CA,CB] = size(M);
N = sum(sum(M));
fenzi = 0;
fenmu = 0;
for i=1:CA
    for j=1:CB
        if M(i,j)~=0
            fenzi = fenzi -2*M(i,j)*log(M(i,j)*N/(sum(M(i,:))*sum(M(:,j))));
        end      
    end
    fenmu = fenmu + sum(M(i,:))*log(sum(M(i,:))/N);
end
for k=1:CB
    fenmu = fenmu+sum(M(:,k))*log(sum(M(:,k))/N);
end
I_A_B = fenzi/fenmu;