function y=lagrl(x0,y0,x)
%x0、y0是n+1维的向量
%x是输入向量

n = length(x0);m = length(x);
for i=1:m
    %对x向量每个求值
    z = x(i);
    s=0.0;
    for k =1:n
        %计算f(xi)
        p=1;
        for j = 1:n
            %计算lk
            if j~=k
                p=p*(z-x0(j))/(x0(k)-x0(j));
            end
        end
        s=p*y0(k)+s;
    end
    y(i)=s;
end

