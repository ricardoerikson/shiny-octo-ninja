clear all;
close all;
clc;

addpath('evaluation','utils','similarity');

data = load('dataset/ua_test_predictions_experiment_std_exp_wgt.mat');

nn_values = [ 5 10 15 20 25 ];

nn_size = max(size(nn_values));

% 1: std values
% 2: exp values
% 3: wgt values
rmse_values = zeros(3,nn_size,nn_size);
mae_values = zeros(3,nn_size,nn_size);

% i = size(knn): k neares neighbors size;
% j = size(exp_knn): expanded neighborhood size;
for i=1:nn_size
	for j=1:nn_size
		prediction_std = data.predict_std(:,i,j);
		prediction_exp = data.predict_exp(:,i,j);
		prediction_wgt = data.predict_wgt(:,i,j);

		rmse_values(1,i,j) = rmse(data.real_values,prediction_std);
		rmse_values(2,i,j) = rmse(data.real_values,prediction_exp);
		rmse_values(3,i,j) = rmse(data.real_values,prediction_wgt);

		mae_values(1,i,j) = mae(data.real_values,prediction_std);
		mae_values(2,i,j) = mae(data.real_values,prediction_exp);
		mae_values(3,i,j) = mae(data.real_values,prediction_wgt);
	end;
end;

