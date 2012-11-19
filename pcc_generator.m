close all;
clear all;
clc;

n_users = 943;
n_movies = 1682;

data = load_data('dataset/u.data',n_users,n_movies);

correlation_matrix = zeros(n_users,n_users);

for i=1:n_users
    parfor j=1:n_users
        if(i~=j)
            correlation_matrix(i,j) = pearson_cc(data(i,:),data(j,:));
        end
    end;
end;

% ratings_count = zeros(n_movies,1);
% for i=1:n_movies
%     ratings_count(i) = size(find(user_movie_ratings(:,i) ~= 0),1);
% end;
% 
% sorted_ratings_count = sort(ratings_count);
% [n,x] =hist(sorted_ratings_count);
% 
