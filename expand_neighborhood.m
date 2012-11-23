function [knn,ex_knn,ex_weight] = expand_neighborhood(k,ex_size,user,item,similarity_matrix,ratings_matrix)

weight_similarity = zeros(1,size(ratings_matrix,1));

neighborhood_vector = ratings_matrix(:,item) > 0;
similarity_vector = similarity_matrix(user,:);

[knn] = nearest_neighbors(k,similarity_vector,neighborhood_vector);

for i=1:max(size(knn))
    
    nn_neighborhood_vector = ratings_matrix(:,item) > 0;
    nn_similarity_vector = similarity_matrix(knn(i),:);
    
    [ex_knn] = nearest_neighbors(k,nn_similarity_vector,nn_neighborhood_vector);
    
    weight_similarity(ex_knn) = weight_similarity(ex_knn) + 1;
    
end;

[sortedValues,sortIndex] = sort(weight_similarity(:),'descend');
ex_weight = sortedValues(sortedValues > 0);
ex_knn = sortIndex(sortedValues > 0);

if (max(size(ex_knn))>ex_size)
    ex_knn = ex_knn(1:ex_size);
    ex_weight = ex_weight(1:ex_size);
end;

end