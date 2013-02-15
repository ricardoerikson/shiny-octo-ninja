close all;
clear('all');
clc;

configure_7

load(['dataset/' experiment_name '/u_data.mat']);

n_users = 943;
n_items = 1682;

nn_values = [ 5 15 25 ];
ex_values = [5 10 20 30];

s_nn = max(size(nn_values));
s_ex = max(size(ex_values));

% EXPANDED PREDICTION

for nn=1:s_nn
	predictions_exp = cell(s_ex,1);
	for ex=1:s_ex
		disp(['exp -- ',num2str(nn),' x ',num2str(ex)]);
		predictions = zeros(n_users,n_items);
		parfor i=1:n_users
			for j=1:n_items
				if(ismember([j],probe_set{i}) || ismember([j],non_observed_set{i}))
					[knn,ex_knn,ex_weight]=expand_neighborhood(nn_values(nn),ex_values(ex),i,j,training_correlation,training_ratings);
					if(max(size(knn))>0)
						predictions(i,j) = predict_rating(i,j,ex_knn,training_ratings,training_correlation);
					end;
				else
					continue;
				end;
			end;
			
		end;
		predictions_exp{ex} = predictions;
		clear predictions;
	end;
	save(['dataset/' experiment_name '/u_data_predictions_exp',num2str(nn),'.mat'],'predictions_exp','-mat');
	clear predictions_exp;
end;
