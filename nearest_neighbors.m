function [knn] = nearest_neighbors(k,similarity_vector,neighborhood)

flagValue = -2;

similarity_vector(neighborhood == 0) = flagValue;
[sortedValues,sortIndex] = sort(similarity_vector(:),'descend');

size = sum(sortedValues > flagValue);
if (size >= k)
    knn = sortIndex(1:k);
else
    knn = sortIndex(1:size);
end;