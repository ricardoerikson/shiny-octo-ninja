close all;
clear all;
clc;

n_users = 943;
n_movies = 1682;

data = load_data('dataset/u.data',n_users,n_movies);



% ratings_count = zeros(n_movies,1);
% for i=1:n_movies
%     ratings_count(i) = size(find(user_movie_ratings(:,i) ~= 0),1);
% end;
% 
% sorted_ratings_count = sort(ratings_count);
% [n,x] =hist(sorted_ratings_count);
% 
