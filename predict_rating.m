% r_ubar (value): mean for user u
% r_vi (vector): rating from user v for item i
% r_vbar (vector): mean for user v
% sim_uv (vector): similarity between user u and v

function [prediction] = predict_rating( user,item,neighbors,ratings_matrix,similarity_matrix )

	[ r_ubar,r_vbar,r_vi,sim_uv] = get_aggregation_par( user,item,neighbors,ratings_matrix,similarity_matrix );

	diff = r_vi - r_vbar;
	sum_part = dot(sim_uv,diff);
	k = 1/sum(abs(sim_uv));

	prediction = r_ubar + k*sum_part;

end