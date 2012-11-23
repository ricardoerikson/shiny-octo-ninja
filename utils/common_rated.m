function [common] = common_rated(vector_a,vector_b)

ones_a = vector_a;
ones_b = vector_b;

obs_a = vector_a ~= 0;
obs_b = vector_b ~= 0;

ones_a(obs_a) = 1;
ones_b(obs_b) = 1;

common_pos = find(ones_a == ones_b);

common = common_pos(ones_a(common_pos) == 1);
