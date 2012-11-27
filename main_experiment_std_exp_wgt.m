close all;
clear all;
clc;

addpath('evaluation','similarity','utils');

data = load('dataset/ua_base_data.mat');
raw_data = load('dataset/ua.test');

test_data = raw_data(:,1:3);
clear raw_data;

nn_size = [5 10 15 20 25];

prediction_std = zeros(max(size(test_data)),max(size(nn_size)),max(size(nn_size)));
prediction_exp = zeros(max(size(test_data)),max(size(nn_size)),max(size(nn_size)));
prediction_wgt = zeros(max(size(test_data)),max(size(nn_size)),max(size(nn_size)));

for i=1:max(size(nn_size))
	for j=1:max(size(nn_size))
		parfor k=1:max(size(test_data))
			[knn,ex_knn,ex_weight]=expand_neighborhood(nn_size(i),nn_size(j),test_data(k,1),test_data(k,2),data.correlation_matrix,data.ratings_matrix);

			if(min(size(knn))>0)
				[st_r_ubar,st_r_vbar,st_r_vi,st_sim_uv] = get_aggregation_par(test_data(k,1),test_data(k,2),knn,data.ratings_matrix,data.correlation_matrix);
				[ext_r_ubar,ext_r_vbar,ext_r_vi,ext_sim_uv] = get_aggregation_par(test_data(k,1),test_data(k,2),ex_knn,data.ratings_matrix,data.correlation_matrix);

				prediction_std(k,i,j) = predict_rating(st_r_ubar,st_r_vi,st_r_vbar,st_sim_uv);
				prediction_exp(k,i,j) = predict_rating(ext_r_ubar,ext_r_vi,ext_r_vbar,ext_sim_uv);
				prediction_wgt(k,i,j) = predict_rating_weighted(ext_r_ubar,ext_r_vi,ext_r_vbar,ext_sim_uv,ex_weight);
			end;
		end;
	end;
end;

% pos_ext = prediction_exp > 0;
% pos_wgt = prediction_wgt > 0;

% rmse_std = rmse(real_value,prediction_std);
% rmse_ext = rmse(real_value(pos_ext),prediction_exp(pos_ext));
% rmse_wgt = rmse(real_value(pos_wgt),prediction_wgt(pos_wgt));

% mae_std = mae(real_value,prediction_std);
% mae_ext = mae(real_value(pos_ext),prediction_exp(pos_ext));
% mae_wgt = mae(real_value(pos_wgt),prediction_wgt(pos_wgt));

clear data pos_wgt pos_ext real_value test_data;