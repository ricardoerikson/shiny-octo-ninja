clear;
clc;

data = load('dataset/ua_base_data_experiment.mat');
raw_data = load('dataset/ua.test');

test_data = raw_data(:,1:3);
clear raw_data;

real_value = test_data(:,3);
prediction_std = zeros(1,max(size(test_data)));
prediction_ext = zeros(1,max(size(test_data)));
prediction_ext_wtd = zeros(1,max(size(test_data)));


parfor i=1:max(size(test_data))
	[knn,ex_knn,ex_weight]=expand_neighborhood(10,10,test_data(i,1),test_data(i,2),data.correlation_matrix,data.ratings_matrix);

	if(min(size(knn))>0)
		[st_r_ubar,st_r_vbar,st_r_vi,st_sim_uv] = get_aggregation_par(test_data(i,1),test_data(i,2),knn,data.ratings_matrix,data.correlation_matrix);
		[ext_r_ubar,ext_r_vbar,ext_r_vi,ext_sim_uv] = get_aggregation_par(test_data(i,1),test_data(i,2),ex_knn,data.ratings_matrix,data.correlation_matrix);

		prediction_std(i) = predict_rating(st_r_ubar,st_r_vi,st_r_vbar,st_sim_uv);
		prediction_ext(i) = predict_rating(ext_r_ubar,ext_r_vi,ext_r_vbar,ext_sim_uv);
		prediction_ext_wtd(i) = predict_rating_weighted(ext_r_ubar,ext_r_vi,ext_r_vbar,ext_sim_uv,ex_weight);
	end;

end;