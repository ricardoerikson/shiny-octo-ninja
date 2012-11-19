function [value] = pearson_cc(vector_a,vector_b)

[obs_pos obs_a obs_b] = items_in_common(vector_a,vector_b);

if(min(size(obs_pos))>0)

    mean_a = mean(vector_a(obs_a));
    mean_b = mean(vector_b(obs_b));

    diff_a = vector_a(obs_pos) - ones(min(size(obs_pos)),max(size(obs_pos)))*mean_a;
    diff_b = vector_b(obs_pos) - ones(min(size(obs_pos)),max(size(obs_pos)))*mean_b;

    value = (diff_a*diff_b')/(sqrt(sum(diff_a.^2))*sqrt(sum(diff_b.^2)));
else
    value = 0;
end;