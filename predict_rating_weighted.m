function [prediction] = predict_rating_weighted( user,item,neighbors,ratings_matrix,similarity_matrix,weight )

	[ r_ubar,r_vbar,r_vi,sim_uv] = get_aggregation_par( user,item,neighbors,ratings_matrix,similarity_matrix );
	
	diff = row(r_vi) - row(r_vbar);
	sum_part = dot(diff.*row(sim_uv),weight);
	k = 1/sum(dot(abs(sim_uv),weight));
	prediction = r_ubar + k*sum_part;

end