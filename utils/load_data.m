function [data] = load_data(filename,u,m)

raw_matrix = load(filename);
data = zeros(u,m);

for i=1:size(raw_matrix,1)
    data(raw_matrix(i,1),raw_matrix(i,2)) = raw_matrix(i,3);
end;

clear raw_matrix;