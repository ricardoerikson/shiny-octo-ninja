% Return parameters
%   r_ubar (value)
%   r_vbar (vector)
%   neighbors (vector)
%   sim_uv (vector)

function [ r_ubar,r_vbar, r_vi, sim_uv] = aggregation_parameters( user,item,neighbors,ratings_matrix,similarity_matrix )

r_ubar = user_mean(ratings_matrix(user,:));
n=max(size(neighbors));

r_vbar = zeros(size(neighbors));
sim_uv = zeros(size(neighbors));
r_vi   = zeros(size(neighbors));

for i=1:n
    r_vbar(i) = user_mean(ratings_matrix(neighbors(i),:));
    sim_uv(i) = similarity(user,neighbors(i),similarity_matrix);
    r_vi(i)   = ratings_matrix(neighbors(i),item);
end

end

