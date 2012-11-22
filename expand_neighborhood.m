function [knn,nn_knn,nn_weight] = expand_neighborhood(k,user,item,similarity_matrix,ratings_matrix)

weight_similarity = zeros(1,size(ratings_matrix,1));

neighborhood_vector = ratings_matrix(:,item) > 0;
similarity_vector = similarity_matrix(user,:);

[knn] = nearest_neighbors(k,similarity_vector,neighborhood_vector);

for i=1:max(size(knn))
    
    nn_neighborhood_vector = ratings_matrix(:,item) > 0;
    nn_similarity_vector = similarity_matrix(knn(i),:);
    
    [nn_knn] = nearest_neighbors(k,nn_similarity_vector,nn_neighborhood_vector);
    
    weight_similarity(nn_knn) = weight_similarity(nn_knn) + 1;
    
end;

[sortedValues,sortIndex] = sort(weight_similarity(:),'descend');
nn_weight = sortedValues(sortedValues > 0);
nn_knn = sortIndex(sortedValues > 0);