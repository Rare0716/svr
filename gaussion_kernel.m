function [K] = gaussion_kernel(x,y,sigma)
%GAUSSION_KERNEL 此处显示有关此函数的摘要
%   此处显示详细说明
% x,y are column vector
gamma=1/(2*sigma*sigma);
len=length(x);
for i=1:len
    for j=1:len
        K(i,j)=exp(-power(x(i)-y(j),2)*gamma);
    end
end
K=K;
end