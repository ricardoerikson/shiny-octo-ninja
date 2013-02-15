close all;
clear('all');
clc;

configure_8

load(['dataset/' experiment_name '/u_data.mat']);

n_users = 943;
n_items = 1682;

nn_values = [5 10 20 30];

s_nn = max(size(nn_values));

% STANDARD PREDICTION

predictions_std = cell(s_nn,1);

for nn=1:s_nn
	predictions = zeros(n_users,n_items);
	parfor i=1:n_users
		disp(['std -- ',num2str(nn),' x ',num2str(i)]);
		for j=1:n_items
			if(ismember([j],probe_set{i}) || ismember([j],non_observed_set{i}))
				[knn]=nearest_neighbors(nn_values(nn),i,j,training_correlation,training_ratings);
				if(max(size(knn))>0)
					predictions(i,j) = predict_rating(i,j,knn,training_ratings,training_correlation);
	 			end;
	 		else
	 			continue;
	 		end;
		end;

	end;
	predictions_std{nn} = predictions;
	clear predictions;
end;

save(['dataset/' experiment_name '/u_data_predictions_std.mat'],'predictions_std','-mat');
clear predictions_std;