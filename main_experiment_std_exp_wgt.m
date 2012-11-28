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

mean_correlation = zeros(2,s_ex,s_nn);

% i = size(knn): k neares neighbors size;
% j = size(exp_knn): expanded neighborhood size;
for i=1:max(size(nn_values))
	for j=1:max(size(exp_values))

		size_nn = 0;
		size_ex = 0;
		sum_nn = 0;
		sum_ex = 0;

		parfor k=1:max(size(test_data))
			[knn,ex_knn,ex_weight]=expand_neighborhood(nn_values(i),exp_values(j),test_data(k,1),test_data(k,2),data.correlation_matrix,data.ratings_matrix);

			if(min(size(knn))>0)
				size_nn = size_nn + 1;
				size_ex = size_ex + 1;

				sum_nn = sum_nn + mean_similarity(test_data(k,1),knn,data.correlation_matrix);
				sum_ex = sum_ex + mean_similarity(test_data(k,1),ex_knn,data.correlation_matrix);

				[st_r_ubar,st_r_vbar,st_r_vi,st_sim_uv] = get_aggregation_par(test_data(k,1),test_data(k,2),knn,data.ratings_matrix,data.correlation_matrix);
				[ext_r_ubar,ext_r_vbar,ext_r_vi,ext_sim_uv] = get_aggregation_par(test_data(k,1),test_data(k,2),ex_knn,data.ratings_matrix,data.correlation_matrix);

				predict_std(k,j,i) = predict_rating(st_r_ubar,st_r_vi,st_r_vbar,st_sim_uv);
				predict_exp(k,j,i) = predict_rating(ext_r_ubar,ext_r_vi,ext_r_vbar,ext_sim_uv);
				predict_wgt(k,j,i) = predict_rating_weighted(ext_r_ubar,ext_r_vi,ext_r_vbar,ext_sim_uv,ex_weight);
			end;
		end;
		% 1: knn mean
		% 2: ex_knn mean
		mean_correlation(1,j,i) = sum_nn/size_nn;
		mean_correlation(2,j,i) = sum_ex/size_ex;

	end;
end;

save('dataset/ua_test_predictions_experiment_std_exp_wgt.mat','real_values','predict_std','predict_exp','mean_correlation','predict_wgt','-mat');