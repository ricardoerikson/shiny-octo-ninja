function [knn,sim] = nearest_neighbors(k,user,item,similarity_matrix,ratings_matrix)

similarity_vector = similarity_matrix(user,:);
neighborhood = ratings_matrix(:,item) > 0;

flagValue = -2;

similarity_vector(neighborhood == 0) = flagValue;
[sortedValues,sortIndex] = sort(similarity_vector(:),'descend');

size = sum(sortedValues > flagValue);
if (size >= k)
    knn = sortIndex(1:k);
	sim = sortedValues(1:k);
else
    knn = sortIndex(1:size);
	sim = sortedValues(1:size);
end;