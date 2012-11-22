% r_ubar (value): mean for user u
% r_vi (vector): rating from user v for item i
% r_vbar (vector): mean for user v
% sim_uv (vector): similarity between user u and v

function [prediction] = aggregation_function(r_ubar,r_vi,r_vbar,sim_uv)

diff = r_vi - r_vbar;
sum_part = dot(sim_uv,diff);
k = 1/sum(abs(sim_uv));

prediction = r_ubar + k*sum_part;