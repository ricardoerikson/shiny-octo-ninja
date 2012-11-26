function [value] = pearson_correlation(vector_a,vector_b)

[common] = common_rated(vector_a,vector_b);

if(min(size(common))>0)

    mean_a = user_mean(vector_a);
    mean_b = user_mean(vector_b);

    diff_a = vector_a(row(common)) - ones(size(row(common)))*mean_a;
    diff_b = vector_b(row(common)) - ones(size(row(common)))*mean_b;

    norm_a = norm(diff_a);
    norm_b = norm(diff_b);

    if(norm_a ~= 0 && norm_b ~= 0)
	    value = dot(diff_a,diff_b)/(norm_a*norm_b);
	else
		value = 0;
    end
else
    value = 0;
end;