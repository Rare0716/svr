close all;
[y,fs]=audioread('1.wav');
real=y(100001:100100,1);
max_value=max(abs(real));
outlier_value=0.8*max_value;
x=1:100;
random_num = sort(x(randperm(numel(x),10)));
%error=awgn(real,15,'measured');
error=add_noise(real,15);
% add_noise,用于增加噪声，input:data,snr_dB
for i=1:10
    error(random_num(i))=min(outlier_value+error(random_num(i)),max_value);
end
%建立回归模型
x=x';
train_x=x/100;%归一化

%sigma=0.001,0.01,0.1
%对应gamma为500000,5000,50
%sigma默认为0.004,gamma为
% 训练模型
default=solve_origin(train_x,error,1,0.003,0.004);
model1=solve_origin(train_x,error,1,0.0005,0.004);
model2=solve_origin(train_x,error,1,0.01,0.004);
model3=solve_origin(train_x,error,1,0.1,0.004);
model4=solve_origin(train_x,error,1,0.003,0.001);
model5=solve_origin(train_x,error,1,0.003,0.01);
model6=solve_origin(train_x,error,1,0.003,0.1);
model7=solve_origin(train_x,error,0.01,0.003,0.004);
model8=solve_origin(train_x,error,0.05,0.003,0.004);
model9=solve_origin(train_x,error,0.09,0.003,0.004);

%预测数据
p_default=origin_predict(train_x,real,default);
pl1 = origin_predict(train_x,real,model1);
pl2 = origin_predict(train_x,real,model2);
pl3 = origin_predict(train_x,real,model3);
pl4 = origin_predict(train_x,real,model4);
pl5 = origin_predict(train_x,real,model5);
pl6 = origin_predict(train_x,real,model6');
pl7 = origin_predict(train_x,real,model7);
pl8 = origin_predict(train_x,real,model8);
pl9 = origin_predict(train_x,real,model9);
time_x=x/fs;%将x变为时间间隔
subplot(3,3,1);
plot(time_x,error,'.');
hold on
plot(time_x,pl1);
legend('加噪数据','ε=0.005');

subplot(3,3,2);
plot(time_x,error,'.');
hold on;
plot(time_x,pl2);
legend('加噪数据','ε=0.01');

subplot(3,3,3);
plot(time_x,error,'.');
hold on;
plot(time_x,pl3);
legend('加噪数据','ε=0.1');

subplot(3,3,4);
plot(time_x,error,'.');
hold on;
plot(time_x,pl4);
legend('加噪数据','σ=0.001');

subplot(3,3,5);
plot(time_x,error,'.');
hold on;
plot(time_x,pl5);
legend('加噪数据','σ=0.01');

subplot(3,3,6);
plot(time_x,error,'.');
hold on;
plot(time_x,pl6);
legend('加噪数据','σ=0.1');

subplot(3,3,7);
plot(time_x,error,'.');
hold on
plot(time_x,pl7);
legend('加噪数据','C=0.01');

subplot(3,3,8);
plot(time_x,error,'.');
hold on;
plot(time_x,pl8);
legend('加噪数据','C=0.05');

subplot(3,3,9);
plot(time_x,error,'.');
hold on;
plot(time_x,pl9);
legend('加噪数据','C=0.09');