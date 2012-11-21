function [value] = consine_similarity(a,b)

value = dot(a,b)/(norm(a)*norm(b));
