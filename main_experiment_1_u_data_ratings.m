close all;
clear('all');
clc;

configure

data = load('dataset/u_data_pearson_correlation.mat');

n_users = 943;
n_items = 1682;

relevant_items = cell(n_users,1);

for i=1:n_users
	members = ismember([4 5],data.ratings_matrix(i,:));
	positions = find(members==1);
	n_highest = size(positions);
	xseq = randperm(n_highest);
	n_relevant = round(0.7*n_highest);

	relevant_set = positions(xseq(1:n_relevant));
	relevant_items{i} = relevant_set;
end;