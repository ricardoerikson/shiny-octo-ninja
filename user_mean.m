function [value] = mean_rating(vector)

value = mean(vector(vector~=0));