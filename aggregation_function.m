function [prediction] = aggregation_function(r_ubar,r_vi,r_vbar,sim_uv)

diff = r_vi - ones(1,max(size(r_vi)))*r_vbar;
sum_part = sim*diff';
k = 1/sum(sim_uv);

prediction = r_ubar + k*sum_part;