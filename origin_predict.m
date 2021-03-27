function [y_pred] = origin_predict(x,y,model)
%ORIGIN_PREDICT 此处显示有关此函数的摘要
%   此处显示详细说明
sigma=model.sigma;
N=100;
I=eye(N);
O=zeros(N);
one=ones(N,1);
zero=zeros(N,1);
K=gaussion_kernel(x,x,sigma);
M1=[I O O zero];
M4=[zeros(N,1)' zeros(N,1)' zeros(N,1)' 1];
theta_vector=M1*model.params_vector;
theta_0=M4*model.params_vector;
K=gaussion_kernel(x,x,sigma);
y_pred=K*theta_vector+theta_0;
%plot(x,y,'x');
%hold on;
%plot(x,y_pred);
end

