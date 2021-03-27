function [res] = add_noise(data,snr_db)
%ADD_NOISE �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
% snr input actually  is snr_db
% input:data,snr_dB
%snr_db=10log10(snr)
%snr=10^(snr_dn/10)
snr=power(10,snr_db/10);
% snr=p_s/p_n
% D(s)=E(s^2)-E(s)^2
p_s=var(data)+mean(data)^2;
p_n=p_s/snr;
sigma=sqrt(p_n);
noise=normrnd(0,sigma,100,1);
% x=(1:100)';
% plot(x,data,'r.');
% hold on;
% plot(x,data+noise);
% legend('ԭʼ����','15dB����');
res=data+noise;
end