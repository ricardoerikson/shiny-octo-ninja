%% rmse: root mean square error
function [value] = rmse(values_a,values_b)
	diff = row(values_a) - row(values_b);
	value = sum(diff.^2)/max(size(diff));
end