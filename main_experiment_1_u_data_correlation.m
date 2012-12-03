clear('all');
close all;
clc;

configure

n_users = 943;
n_items = 1682;

ratings_matrix = load_data('dataset/u.data',n_users,n_items);

probe_set = cell(n_users,1);
training_set = cell(n_users,1);
non_observed_set = cell(n_users,1);

parfor i=1:n_users

	all_observed = find(ratings_matrix(i,:) > 0);
	observed_positions = ratings_matrix(i,:) > 0;
	all_values = ratings_matrix(i,observed_positions);

	[sortedValues,sortedIndexes] = sort(all_values,'descend');
	all_observed_sorted = all_observed(sortedIndexes);

	n_observed = max(size(all_observed_sorted));

	ten_pc = 0.1*n_observed;

	probe_set{i} = all_observed_sorted(1:ten_pc);
	training_set{i} = all_observed_sorted(ten_pc+1:end);

	non_observed = find(ratings_matrix(i,:)==0);
	non_observed_set{i} = non_observed;

end;

[training_correlation,training_ratings] = correlation('dataset/u.data',n_users,n_items,0,probe_set);

save('dataset/u_data_experiment_1.mat','non_observed_set','training_correlation','training_ratings','probe_set','training_set','ratings_matrix','-mat');