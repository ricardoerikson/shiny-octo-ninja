function [C,R] = correlation(dataset,n_users,n_items,type,probe);
	% CORRELATION Determine the correlation between users
	% 
	%   [C,R] = CORRELATION(dataset,n_users,n_items,type) 
	%   calculates the correlation between users of the dataset. 
	%   C(n_users x n_users) is the resulting correlation matrix 
	%   and R (n_users x n_items) is the resulting ratings matrix.
	%
	%   [C,R] = CORRELATION(dataset,n_users,n_items,type,probe) 
	%   calculates the correlation between the users excluding 
	%   the probe set.

	switch nargin
		case 4
			hasProbe = 0;
		case 5
			hasProbe = 1;
		otherwise
			error('Unexpected input.');
	end

	R = load_data(dataset,n_users,n_items);
	C = zeros(n_users,n_users);
	
	if(hasProbe == 1)
		for i=1:n_users
			R(probe{i}) = 0;
		end;
	end;

	parfor i=1:n_users
		vector_i = R(i,:);
		for j=1:n_users
			if(i~=j)
				if (type==0)
					C(i,j) = pearson_correlation(vector_i,R(j,:));
				elseif (type==1)
					C(i,j) = cosine_similarity(vector_i,R(j,:));
				end
			end
		end;
	end;

end