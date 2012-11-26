close all;
clear all;
clc;

n_users = 943;
n_movies = 1682;

ratings_matrix = load_data('dataset/ua.base',n_users,n_movies);

correlation_matrix = zeros(n_users,n_users);

parfor i=1:n_users
    vector_i = ratings_matrix(i,:);
    for j=1:n_users
        if(i~=j)
            correlation_matrix(i,j) = pearson_correlation(vector_i,ratings_matrix(j,:));
        end
    end;
end;

save('dataset/ua_base_data.mat','correlation_matrix','ratings_matrix','-mat');