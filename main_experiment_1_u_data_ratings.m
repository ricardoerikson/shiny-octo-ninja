close all;
clear('all');
clc;

configure

load('dataset/u_data_experiment_1.mat');

n_users = 943;
n_items = 1682;

nn_values = [ 5 10 15 20 25 ];
ex_values = 4:2:30;

s_nn = max(size(nn_values));
s_ex = max(size(ex_values));

% STANDARD PREDICTION

predictions_std = cell(s_ex,s_nn);

for nn=1:s_nn
	for ex=1:s_ex
		predictions = sparse(zeros(n_users,n_items));
		parfor i=1:n_users
			for j=1:n_items

				[knn,ex_knn,ex_weight]=expand_neighborhood(nn_values(nn),ex_values(ex),i,j,training_correlation,training_ratings);
				if(max(size(knn))>0)
					predictions(i,j) = predict_rating(i,j,knn,training_ratings,training_correlation);
				end;
			end;
			disp(['std -- ',num2str(nn),' x ',num2str(ex),' user-',num2str(i)]);
		end;
		predictions_std{ex,nn} = predictions;
		clear predictions;
	end;
end;

save('dataset/experiment1/std/u_data_predictions_std.mat','predictions_std','-mat');
clear predictions_std;

% EXPANDED PREDICTION

predictions_wgt = cell(s_ex,s_nn);

for nn=1:s_nn
	for ex=1:s_ex
		predictions = sparse(zeros(n_users,n_items));
		parfor i=1:n_users
			for j=1:n_items

				[knn,ex_knn,ex_weight]=expand_neighborhood(nn_values(nn),ex_values(ex),i,j,training_correlation,training_ratings);
				if(max(size(knn))>0)
					predictions(i,j) = predict_rating(i,j,ex_knn,training_ratings,training_correlation,ex_weight);
				end;
			end;
			disp(['wgt -- ',num2str(nn),' x ',num2str(ex),' user-',num2str(i)]);
		end;
		predictions_wgt{ex,nn} = predictions;
		clear predictions;
	end;
end;

save('dataset/experiment1/wgt/u_data_predictions_wgt.mat','predictions_wgt','-mat');
clear predictions_wgt;

% WEIGHTED PREDICTION

predictions_exp = cell(s_ex,s_nn);

for nn=1:s_nn
	for ex=1:s_ex
		predictions = sparse(zeros(n_users,n_items));
		parfor i=1:n_users
			for j=1:n_items

				[knn,ex_knn,ex_weight]=expand_neighborhood(nn_values(nn),ex_values(ex),i,j,training_correlation,training_ratings);
				if(max(size(knn))>0)
					predictions(i,j) = predict_rating(i,j,ex_knn,training_ratings,training_correlation);
				end;
			end;
			disp(['exp -- ',num2str(nn),' x ',num2str(ex),' user-',num2str(i)]);
		end;
		predictions_exp{ex,nn} = predictions;
		clear predictions;
	end;
end;

save('dataset/experiment1/exp/u_data_predictions_exp.mat','predictions_exp','-mat');
clear predictions_exp;