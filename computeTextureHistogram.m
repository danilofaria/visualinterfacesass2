function [histograms] = computeTextureHistogram( laplacians, nImages )

	divide_space_by = 30;

	% compute dimensions of images
	lapIm = laplacians{1};
	[rows,columns] = size(lapIm);

	histograms = {}
	for n=1:nImages
		lapIm = laplacians{n};

		keys={'0'};
		values={0};
		histogram = containers.Map(keys, values);

		for i=1:rows
			for j=1:columns
				
				% compute key
				key = lapIm(i,j);
				key = int2str(key-mod(key,divide_space_by));

				if(histogram.isKey(key))
					histogram(key) = 1 + histogram(key);
				else 
					histogram(key) = 1;
				end
			end
		end

		histograms{n} = histogram;
	end

end