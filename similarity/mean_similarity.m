%% mean_similarity:neighbors,correlation_matrix description
function [value] = mean_similarity(user,neighbors,correlation_matrix)

	value = mean(correlation_matrix(user,neighbors));

end