close all;
clear('all');
clc;

configure

start = clock;

load('dataset/u_data_experiment_1.mat');

n_users = 943;
n_items = 1682;

nn_values = [ 5 15 25 ];
ex_values = 5:5:30;

s_nn = max(size(nn_values));
s_ex = max(size(ex_values));

% WEIGHTED PREDICTION

for nn=1:s_nn
	predictions_wgt = cell(s_ex,1);
	for ex=1:s_ex
		disp(['wgt -- ',num2str(nn),' x ',num2str(ex)]);
		predictions = sparse(zeros(n_users,n_items));
		parfor i=1:n_users
			for j=1:n_items

				[knn,ex_knn,ex_weight]=expand_neighborhood(nn_values(nn),ex_values(ex),i,j,training_correlation,training_ratings);
				if(max(size(knn))>0)
					predictions(i,j) = predict_rating(i,j,ex_knn,training_ratings,training_correlation,ex_weight);
				end;
			end;
			
		end;
		predictions_wgt{ex} = predictions;
		clear predictions;
	end;
	save(['dataset/experiment1/u_data_predictions_wgt',num2str(nn),'.mat'],'predictions_wgt','-mat');
	clear predictions_wgt;
end;

finish = clock;