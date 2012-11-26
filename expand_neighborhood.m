function [knn,ex_knn,ex_weight] = expand_neighborhood(k,ex_size,user,item,similarity_matrix,ratings_matrix)

weight_similarity = zeros(1,size(ratings_matrix,1));

[knn] = nearest_neighbors(k,user,item,similarity_matrix,ratings_matrix);

if(min(size(knn))>0)
	for i=1:max(size(knn))
	    
	    [ex_knn] = nearest_neighbors(ex_size,knn(i),item,similarity_matrix,ratings_matrix);
	    
	    weight_similarity(ex_knn) = weight_similarity(ex_knn) + 1;
	    
	end;

	[sortedValues,sortIndex] = sort(weight_similarity(:),'descend');
	ex_weight = sortedValues(sortedValues > 0);
	ex_knn = sortIndex(sortedValues > 0);

	if (max(size(ex_knn))>ex_size)
	    ex_knn = ex_knn(1:ex_size);
	    ex_weight = ex_weight(1:ex_size);
	end;
else
	ex_knn = knn;
	ex_weight = knn;
end;


end