
% Calculating similarity
configure;

n_users = 943;
n_items = 1682;
mkdir(['dataset/' experiment_name]);
load('dataset/u_data_t50_p50.mat');
[training_correlation,training_ratings] = correlation('dataset/u.data',n_users,n_items,1,probe_set);
save(['dataset/' experiment_name '/u_data.mat'],'non_observed_set','training_correlation','training_ratings','probe_set','training_set','ratings_matrix','-mat');

% Calculating predictions
main_u_data_prediction_std_8
main_u_data_prediction_exp_8
main_u_data_prediction_wgt_8
