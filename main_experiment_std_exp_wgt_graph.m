clear all;
close all;
clc;

addpath('evaluation','utils','similarity');

data = load('dataset/ua_test_predictions_experiment_std_exp_wgt.mat');

nn_values = [ 5 10 15 20 25 ];
exp_values = 4:2:30;

s_nn = max(size(nn_values));
s_ex = max(size(exp_values));

% 1: std values
% 2: exp values
% 3: wgt values
rmse_values = zeros(3,s_ex,s_nn);
mae_values = zeros(3,s_ex,s_nn);

% i = size(knn): k neares neighbors size;
% j = size(exp_knn): expanded neighborhood size;
for i=1:s_nn
	for j=1:s_ex
		prediction_std = data.predict_std(:,j,i);
		prediction_exp = data.predict_exp(:,j,i);
		prediction_wgt = data.predict_wgt(:,j,i);

		sel_predict_exp = prediction_exp(prediction_exp>0);
		sel_predict_wgt = prediction_wgt(prediction_wgt>0);

		sel_real_exp = data.real_values(prediction_exp>0);
		sel_real_wgt = data.real_values(prediction_wgt>0);

		rmse_values(1,j,i) = rmse(data.real_values,prediction_std);
		rmse_values(2,j,i) = rmse(sel_real_exp,sel_predict_exp);
		rmse_values(3,j,i) = rmse(sel_real_wgt,sel_predict_wgt);

		mae_values(1,j,i) = mae(data.real_values,prediction_std);
		mae_values(2,j,i) = mae(sel_real_exp,sel_predict_exp);
		mae_values(3,j,i) = mae(sel_real_wgt,sel_predict_wgt);
	end;
end;

hFig = figure(1);
set(hFig, 'Position', [50 100 1000 250]);

subplot(1,3,1);
plot(exp_values,rmse_values(1,:,1),'-.k');
hold all;
plot(exp_values,rmse_values(2,:,1),'-r');
hold all;
plot(exp_values,rmse_values(3,:,1),':b');
hleg = legend('kNN','exp-kNN','exp-kNN+wgt',...
              'Location','NorthEast');
set(hleg,'FontAngle','italic');
xlabel('Vizinhança (exp-kNN).');
ylabel('RMSE');
hold all;
annotation('textbox', [.02 .5 .1 .1], 'String', 'k=5','EdgeColor','none');

subplot(1,3,2);
plot(exp_values,mae_values(1,:,1),'-.k');
hold all;
plot(exp_values,mae_values(2,:,1),'-r');
hold all;
plot(exp_values,mae_values(3,:,1),':b');
hleg = legend('kNN','exp-kNN','exp-kNN+wgt',...
              'Location','NorthEast');
set(hleg,'FontAngle','italic');
xlabel('Vizinhança (exp-kNN).');
ylabel('MAE');

subplot(1,3,3);
plot(exp_values,data.mean_correlation(1,:,1),'-ok');
hold all;
plot(exp_values,data.mean_correlation(2,:,1),'-*r');
hleg = legend('kNN','exp-kNN',...
              'Location','East');
set(hleg,'FontAngle','italic');
xlabel('Vizinhança (exp-kNN).');
ylabel('Valor médio de correlação');
