function [value common_items] = pearson_cc(vector_a,vector_b)

aux_vector_a = vector_a;
aux_vector_b = vector_b;

observed_items_a = vector_a ~= 0;
observed_items_b = vector_b ~= 0;

aux_vector_a(observed_items_a) = 1;
aux_vector_b(observed_items_b) = 1;

common_pos = find(aux_vector_a == aux_vector_b);

common_items = common_pos(aux_vector_a(common_pos) == 1);

mean_a = mean(vector_a(observed_items_a));
mean_b = mean(vector_b(observed_items_b));

diff_a = vector_a(common_items) - ones(min(size(common_items)),max(size(common_items)))*mean_a;
diff_b = vector_b(common_items) - ones(min(size(common_items)),max(size(common_items)))*mean_b;

value = (diff_a*diff_b')/(sqrt(sum(diff_a.^2))*sqrt(sum(diff_b.^2)));