function [most_alike] = fourMostAlike( difs, nImages )

	clusters_closeness = 1-difs;

	% find first four images to stay together
	complete_linkage = linkage(clusters_closeness, 'complete');

	clusters = {}
	for i=1:nImages
		clusters{i} =[i];
	end

	most_alike = []
	for i=1:(nImages-1)
		new_i = length(clusters)+1
		clusters{new_i} = [clusters{complete_linkage(i,1)} clusters{complete_linkage(i,2)}]
		if (length(clusters{new_i}) >= 4)
			most_alike = clusters{new_i};
			break;
		end
	end

	most_alike = most_alike(1:4);

end