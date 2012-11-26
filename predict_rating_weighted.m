function [prediction] = predict_rating_weighted(r_ubar,r_vi,r_vbar,sim_uv,weight)

diff = row(r_vi) - row(r_vbar);

sum_part = dot(diff.*row(sim_uv),weight);
k = 1/sum(dot(abs(sim_uv),weight));

prediction = r_ubar + k*sum_part;

end