function [ v ] = row( vector )

s = size(vector);
if(s(1)>s(2))
    v = vector';
else
    v = vector;
end;

end