function [most_unalike] = fourMostUnalike( difs, nImages )
 
 	clusters_closeness = 1-difs;

	% find first four images to be left alone
	single_linkage = linkage(clusters_closeness, 'single');

	clusters = {}
	for i=1:nImages
		clusters{i} =[i];
	end

	n=nImages;

	for i=1:(nImages-1)
		el1 = single_linkage(i,1)
		el2 = single_linkage(i,2)

		if(el1 <= nImages)
			n = n -1;
			clusters{el1} = [];
		end

		if (n == 4)
			break;
		end

		if(el2 <= nImages)
			n = n -1;
			clusters{el2} = [];
		end

		if (n == 4)
			break;
		end
		
	end

	% put the result in a vector
	most_unalike = [];
	n=1;
	for i=1:nImages
		if (isempty(clusters{i}))
			continue;
		end
		most_unalike(n) = clusters{i};
		n = n+1;
	end

end