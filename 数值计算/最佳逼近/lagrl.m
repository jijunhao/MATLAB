function y=lagrl(x0,y0,x)
%x0��y0��n+1ά������
%x����������

n = length(x0);m = length(x);
for i=1:m
    %��x����ÿ����ֵ
    z = x(i);
    s=0.0;
    for k =1:n
        %����f(xi)
        p=1;
        for j = 1:n
            %����lk
            if j~=k
                p=p*(z-x0(j))/(x0(k)-x0(j));
            end
        end
        s=p*y0(k)+s;
    end
    y(i)=s;
end

