function [KNN] = nearest_neighbors(k,similarity_vector,neighborhood)

flagValue = -2;

similarity_vector(neighborhood == 0) = flagValue;
[sortedValues,sortIndex] = sort(similarity_vector(:),'descend');

size = sum(sortedValues > flagValue);
if (size >= k)
    KNN = sortIndex(1:k);
else
    KNN = sortIndex(1:size);
end;