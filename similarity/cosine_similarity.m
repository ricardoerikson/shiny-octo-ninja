function [value] = cosine_similarity(a,b)

value = dot(a,b)/(norm(a)*norm(b));
