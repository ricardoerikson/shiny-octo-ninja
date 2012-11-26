%% precision: function description
function [value] = precision(top_l,relevant_elements)
	d_l = sum(ismember(relevant_elements,top_l));
	value = d_l/max(size(top_l));
end