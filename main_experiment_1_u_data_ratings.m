close all;
clear('all');
clc;

configure

load('dataset/u_data_experiment_1.mat');

n_users = 943;
n_items = 1682;

nn_values = [ 5 10 15 20 25 ];
exp_values = 4:2:30;

nnn_values = max(size(nn_values));
nexp_values = max(size(exp_values));

predictions_std = zeros(n_users,n_items,nexp_values,nnn_values);
predictions_exp = zeros(n_users,n_items,nexp_values,nnn_values);
predictions_wgt = zeros(n_users,n_items,nexp_values,nnn_values);

for nn=1:max(size(nn_values))
	for ex=1:max(size(exp_values))
		for i=1:n_users
			for j=1:n_items

				[knn,ex_knn,ex_weight]=expand_neighborhood(nn_values(nn),exp_values(ex),i,j,training_correlation,training_ratings);
				if(max(size(knn))>0)
					std_rating = predict_rating(i,j,knn,training_ratings,training_correlation);
					exp_rating = predict_rating(i,j,ex_knn,training_ratings,training_correlation);
					wgt_rating = predict_rating_weighted(i,j,ex_knn,training_ratings,training_correlation,ex_weight);

					predictions_std(i,j,ex,nn) = std_rating;
					predictions_exp(i,j,ex,nn) = exp_rating;
					predictions_wgt(i,j,ex,nn) = wgt_rating;

				end;

			end;
		end;

	end;
end;

save('dataset/u_data_experiment_1_predictions.mat','predictions_wgt','predictions_exp','predictions_std','-mat');