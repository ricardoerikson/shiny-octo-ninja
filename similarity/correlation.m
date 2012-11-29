%% functionname: function description
function [M,R] = correlation(dataset,n_users,n_items,type);

	R = load_data(dataset,n_users,n_items);

	M = zeros(n_users,n_users);

	parfor i=1:n_users
		vector_i = R(i,:);
		for j=1:n_users
			if(i~=j)
				if (type==0)
					M(i,j) = pearson_correlation(vector_i,R(j,:));
				elseif (type==1)
					M(i,j) = cosine_similarity(vector_i,R(j,:));
				end
			end
		end;
	end;

end