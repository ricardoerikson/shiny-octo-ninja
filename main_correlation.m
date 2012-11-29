close all;
clear all;
clc;

n_users = 943;
n_movies = 1682;

[correlation_matrix,ratings_matrix]=correlation('dataset/ua.base',n_users,n_movies,0);

save('dataset/ua_base_data_experiment.mat','correlation_matrix','ratings_matrix','-mat');