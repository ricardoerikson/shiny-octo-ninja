%% mae: mean absolute error
function [value] = mae(values_a,values_b)
	diff = abs(row(values_a) - row(values_b));
	value = sum(diff)/max(size(diff));
end