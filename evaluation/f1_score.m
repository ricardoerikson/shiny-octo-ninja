%% f1_score: function description
function [f1,p,r] = f1_score(top_l,relevant_elements)
	p = precision(top_l,relevant_elements);
	r = recall(top_l,relevant_elements);
	f1 = 2*p*r/(p+r);
end