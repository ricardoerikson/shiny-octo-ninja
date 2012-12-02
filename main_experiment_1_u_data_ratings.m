close all;
clear('all');
clc;

configure

data = load('dataset/u_data_pearson_correlation.mat');

n_users = 943;
n_items = 1682;

probe_set = cell(n_users,1);
training_set = cell(n_users,1);

parfor i=1:n_users

	all_observed = find(data.ratings_matrix(i,:) > 0);
	[sortedValues,sortedIndexes] = sort(all_observed,'descend');
	all_observed_sorted = all_observed(sortedIndexes);

	n_observed = max(size(all_observed_sorted));
	n_half = round(0.5*n_observed);
	xseq = randperm(n_half);
	n_probe = round(0.4*n_half);

	probe_set{i} = all_observed_sorted(xseq(1:n_probe));
	training_set{i} = cat(2,all_observed_sorted(xseq(n_probe+1:end)),all_observed_sorted(n_half+1:end));

end;