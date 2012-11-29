clear('all');
close all;
clc;

[correlation_matrix,ratings_matrix]=correlation('dataset/u.data',943,1682,0);

save('dataset/u_data_pearson_correlation.mat','correlation_matrix','ratings_matrix','-mat');
