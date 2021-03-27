function [data] = set_outlier(data,num)
%SET_OUTLIER 此处显示有关此函数的摘要
%   此处显示详细说明
x=1:100;
max_value=max(abs(data));
random_num = sort(x(randperm(numel(x),10)));
outlier_value=0.8*max_value;
for i=1:num
    data(random_num(i))=min(outlier_value+data(random_num(i)),max_value);
end
end

