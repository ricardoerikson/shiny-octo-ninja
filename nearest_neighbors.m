function [KNN] = nearest_neighbors(k,pos,similarity_vector)

[sortedValues,sortIndex] = sort(similarity_vector(:),'descend');
self_similarity = (sortIndex == pos);
neighbors = sortIndex(self_similarity == 0);
if(max(size(neighbors))>k)
    KNN = neighbors(1:k);
else
    KNN = neighbors;
end;