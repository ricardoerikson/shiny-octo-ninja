function [value] = pearson_correlation(vector_a,vector_b)

[common] = common_rated(vector_a,vector_b);

if(min(size(common))>0)

    mean_a = user_mean(vector_a);
    mean_b = user_mean(vector_b);

    diff_a = vector_a(common) - ones(min(size(common)),max(size(common)))*mean_a;
    diff_b = vector_b(common) - ones(min(size(common)),max(size(common)))*mean_b;

    value = (diff_a*diff_b')/(sqrt(sum(diff_a.^2))*sqrt(sum(diff_b.^2)));
else
    value = 0;
end;