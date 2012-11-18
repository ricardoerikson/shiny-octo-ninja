close all;
clear all;
clc;

data = load('dataset/u.data');

n_users = 943;
n_movies = 1682;

user_movie_ratings = zeros(n_users,n_movies);

for i=1:size(data,1)
    user_movie_ratings(data(i,1),data(i,2)) = data(i,3);
end;

ratings_count = zeros(n_movies,1);
for i=1:n_movies
    ratings_count(i) = size(find(user_movie_ratings(:,i) ~= 0),1);
end;

sorted_ratings_count = sort(ratings_count);
[n,x] =hist(sorted_ratings_count);

