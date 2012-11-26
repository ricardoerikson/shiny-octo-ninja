%% recall: function description
function [value] = recall(top_l,relevant_elements)
	d_l = sum(ismember(relevant_elements,top_l));
	value = d_l/max(size(relevant_elements));
end