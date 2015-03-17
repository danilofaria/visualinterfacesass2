function [matches] = countMatches( difs, surveys, nImages )

	% sort by similarity
	[difs_sorted difs_index] = sort(difs);
	difs_index = [difs_index(1:3,:); difs_index(nImages-2-1:nImages-1,:)]

	% keep only 3 most similar and 3 most dissimilar
	difs_sorted = [difs_sorted(1:3,:); difs_sorted(nImages-2-1:nImages-1,:)]
	% transpose the matrices
	difs_index = difs_index'
	difs_sorted = difs_sorted'

	% rearrange so each row has the 3 most 
	% similar images followed by the 3 least similar 
	difs_sorted = [difs_sorted(:,6) difs_sorted(:,5) difs_sorted(:,4) difs_sorted(:,1:3)]  
	difs_index = [difs_index(:,6) difs_index(:,5) difs_index(:,4) difs_index(:,1:3)]  

	matches = [0 0 0 0 0 0];

	% count time survey answers matches with algorithm's
	n = length(surveys);
	for s_i=1:n 
		survey = surveys{s_i};
		for i=1:nImages
			for j=1:6
				if (difs_index(i,j) == survey(i,floor((j-1)/3)+1))
					matches(j) = matches(j) + 1;
				end
			end
		end
	end

	% sum matches 
	matches = [sum(matches(1:3)) sum(matches(4:6))];
	% normalize
	matches = matches/(nImages*n);

end