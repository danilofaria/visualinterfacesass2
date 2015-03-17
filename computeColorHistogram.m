function [histograms] = computeColorHistogram( ims, nImages )

	interval_size = 40;
	discard_threshold = 10;

	% compute dimensions of images
	im = ims{1};
	[rows,columns,colors] = size(im);

	histograms = {};
	for n=1:nImages
		im = ims{n};

		keys={'0,0,0'};
		values={0};
		histogram = containers.Map(keys, values);

		for i=1:rows
			for j=1:columns
				key = im(i,j,:);

				% discard pixels with all r,g and b values lower than 10
				if ((key(1) < discard_threshold) && (key(2) < discard_threshold) && (key(3) < discard_threshold))
					continue;
				end

				% compute key
				key = strcat(int2str(key(1)-mod(key(1),interval_size) ),',',int2str(key(2)-mod(key(2),interval_size) ),',',int2str(key(3)-mod(key(3),interval_size) ));

				if(histogram.isKey(key))
					histogram(key) = 1 + histogram(key);
				else 
					histogram(key) = 1;
				end

			end
		end

		remove(histogram,{'0,0,0'});

		histograms{n} = histogram;
	end

end