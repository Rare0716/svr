function res = solve_origin(x,y,C,epsilon,sigma)
%SOLVE_ORIGIN 此处显示有关此函数的摘要
%   此处显示详细说明
%m=[theta epsilon epsilon_hat theta_0]';
N=length(x);
I=eye(N);
O=zeros(N);
one=ones(N,1);
zero=zeros(N,1);
K=gaussion_kernel(x,x,sigma);
M1=[I O O zero];%build transfer matrix to theta_vector
M2=[O I O zero];%to \xi
M3=[O O I zero];%to \tilde{\xi}
M4=[zeros(N,1)' zeros(N,1)' zeros(N,1)' 1];%to \theta_0
H=M1'*M1; 
f=C*(M2+M3)'*one;
epsilon_vector=epsilon.*ones(N,1);

A=[-K'*M1-M4-M3;K'*M1+M4-M2;-M3;-M2];%Ax\ge b
b=[epsilon_vector-y;y+epsilon_vector;zero;zero];

params_vector=quadprog(H,f,A,b);

res.params_vector=params_vector;
res.sigma=sigma;
res.C=C;
res.epsilon=epsilon;
end

