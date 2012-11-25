clear;
clc;

data = load('dataset/ua_base_data.mat');
raw_data = load('dataset/ua.test');

test_data = raw_data(:,1:3);
clear raw_data;

real_value = test_data(:,3);
prediction.std = zeros(1,max(size(test_data)));
prediction.ext = zeros(1,max(size(test_data)));
prediction.ext_wtd = zeros(1,max(size(test_data)));


for i=1:max(size(test_data))
	[knn,ex_knn,ex_weight]=expand_neighborhood(10,10,test_data(i,1),test_data(i,2),data.correlation_matrix,data.ratings_matrix);

	if(min(size(knn))>0)
		[st.r_ubar,st.r_vbar,st.r_vi,st.sim_uv] = get_aggregation_par(test_data(i,1),test_data(i,2),knn,data.ratings_matrix,data.correlation_matrix);
		[ext.r_ubar,ext.r_vbar,ext.r_vi,ext.sim_uv] = get_aggregation_par(test_data(i,1),test_data(i,2),ex_knn,data.ratings_matrix,data.correlation_matrix);

		prediction.std(i) = predict_rating(st.r_ubar,st.r_vi,st.r_vbar,st.sim_uv);
		prediction.ext(i) = predict_rating(ext.r_ubar,ext.r_vi,ext.r_vbar,ext.sim_uv);
		prediction.ext_wtd(i) = predict_rating_weighted(ext.r_ubar,ext.r_vi,ext.r_vbar,ext.sim_uv,ex_weight);
	end;

end;