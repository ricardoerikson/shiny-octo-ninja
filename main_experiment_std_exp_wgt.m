close all;
clear all;
clc;

addpath('evaluation','similarity','utils');

data = load('dataset/ua_base_data_experiment.mat');
raw_data = load('dataset/ua.test');

test_data = raw_data(:,1:3);
clear raw_data;

nn_values = [5 10 15 20 25];
exp_values = 4:2:30;

s_nn = max(size(nn_values));
s_ex = max(size(exp_values));
s_ts = max(size(test_data));

real_values = test_data(:,3);

predict_std = zeros(s_ts,s_ex,s_nn);
predict_exp = zeros(s_ts,s_ex,s_nn);
predict_wgt = zeros(s_ts,s_ex,s_nn);

% i = size(knn): k neares neighbors size;
% j = size(exp_knn): expanded neighborhood size;
for i=1:max(size(nn_values))
	for j=1:max(size(exp_values))
		parfor k=1:max(size(test_data))
			[knn,ex_knn,ex_weight]=expand_neighborhood(nn_values(i),exp_values(j),test_data(k,1),test_data(k,2),data.correlation_matrix,data.ratings_matrix);

			if(min(size(knn))>0)
				[st_r_ubar,st_r_vbar,st_r_vi,st_sim_uv] = get_aggregation_par(test_data(k,1),test_data(k,2),knn,data.ratings_matrix,data.correlation_matrix);
				[ext_r_ubar,ext_r_vbar,ext_r_vi,ext_sim_uv] = get_aggregation_par(test_data(k,1),test_data(k,2),ex_knn,data.ratings_matrix,data.correlation_matrix);

				predict_std(k,j,i) = predict_rating(st_r_ubar,st_r_vi,st_r_vbar,st_sim_uv);
				predict_exp(k,j,i) = predict_rating(ext_r_ubar,ext_r_vi,ext_r_vbar,ext_sim_uv);
				predict_wgt(k,j,i) = predict_rating_weighted(ext_r_ubar,ext_r_vi,ext_r_vbar,ext_sim_uv,ex_weight);
			end;
		end;
	end;
end;

save('dataset/ua_test_predictions_experiment_std_exp_wgt.mat','real_values','predict_std','predict_exp','predict_wgt','-mat');