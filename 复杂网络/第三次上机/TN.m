K=4;N=[200,300,500,1000];n=8;
URW_total=zeros(1,n);
NRRW_total=zeros(1,n);
SARW_total=zeros(1,n);
URW_Aver_Search_times=zeros(1,length(N));
NRRW_Aver_Search_times=zeros(1,length(N));
SARW_Aver_Search_times=zeros(1,length(N));
for t=1:length(N)
    A=CNCN(N(t),K);
    rand_s=randperm(N(t));
    URW_t=zeros(1,N(t));
    NRRW_t=zeros(1,N(t));
    SARW_t=zeros(1,N(t));
    for j=1:n
        for i=1:N(t)
            URW_t(i)=myURW(A,rand_s(j),i);
            NRRW_t(i)=myNRRW(A,rand_s(j),i);
            SARW_t(i)=mySARW(A,rand_s(j),i);
        end
        URW_total(j)=sum(URW_t);
        NRRW_total(j)=sum(NRRW_t);
        SARW_total(j)=sum(SARW_t);
    end
    URW_Aver_Search_times(t)=sum(URW_total)/(n*(N(t)-1));
    NRRW_Aver_Search_times(t)=sum(NRRW_total)/(n*(N(t)-1));
    SARW_Aver_Search_times(t)=sum(SARW_total)/(n*(N(t)-1));
end
hold on;
plot(N,log(URW_Aver_Search_times),'r+-');
plot(N,log(NRRW_Aver_Search_times),'gx-');
plot(N,log(SARW_Aver_Search_times),'bs-');
plot(N,log(N.^2.*(1+0.86*log(K))/(6*K^2)),'yo-');
legend('URW','NRRW','SARW','URW(Pandit%Amritkar)','Location','northwest');
xlabel('网络规模N');ylabel('平均搜索步数logT');
    
            
