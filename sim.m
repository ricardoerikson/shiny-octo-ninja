function [value] = sim(u,v,correlation_matrix)

if(u~=v)
    value = correlation_matrix(u,v);
else
    value = 0;
end;