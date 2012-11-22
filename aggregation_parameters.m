% Return parameters
%   r_ubar (value)
%   r_vbar (vector)
%   r_vi (vector)
%   sim_uv (vector)

function [ r_ubar,r_vbar, r_vi, sim_uv] = aggregation_parameters( user,item,neighbors,ratings_matrix,similarity_matrix )

r_ubar = user_mean(ratings_matrix(user,:));
n=max(size(r_vi));

r_vbar = zeros(size(r_vi));
sim_uv = zeros(size(r_vi));

for i=1:n
    r_vbar(i) = user_mean(ratings_matrix(r_vi(i),:));
    sim_uv(i) = similarity(user,r_vi(i),similarity_matrix);
end

end

