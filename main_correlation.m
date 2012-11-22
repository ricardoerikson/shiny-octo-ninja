close all;
clear all;
clc;

n_users = 943;
n_movies = 1682;

data = load_data('dataset/ua.base',n_users,n_movies);

correlation_matrix = zeros(n_users,n_users);

parfor i=1:n_users
    vector_i = data(i,:);
    for j=1:n_users
        if(i~=j)
            correlation_matrix(i,j) = pearson_correlation(vector_i,data(j,:));
        end
    end;
end;

save('dataset/pearson_correlation_base.mat','correlation_matrix','-mat');