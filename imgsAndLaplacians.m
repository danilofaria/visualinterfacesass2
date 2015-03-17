function [ims, laplacians, labeled_ims] = imgsAndLaplacians(nImages)

	laplacians = {};
	ims = {};
	labeled_ims = {};

	for k=1:nImages

		if k < 10
			im = imread(strcat('imgs/i0',int2str(k),'.ppm'));
			labeled_ims{k} = imread(strcat('labeledimgs/i0',int2str(k),'.png'));
		else 
			im = imread(strcat('imgs/i',int2str(k),'.ppm'));
			labeled_ims{k} = imread(strcat('labeledimgs/i',int2str(k),'.png'));
		end

		ims{k} = im;

		% Convert to grayscale (R + G + B)/3
		grayIm = (im(:,:,1) + im(:,:,2) + im(:,:,2))/3;

		% Laplacian
		[rows,columns] = size(grayIm);
		% make it double type to allow for negative values 
		laplacian = double(grayIm)*8;

		for i=1:rows
			for j=1:columns
				for a = max(1,i-1) : min(rows,i+1)
					for b=max(1,j-1):min(columns,j+1)
						if(a ~=i || b ~= j)
							laplacian(i,j) = laplacian(i,j) - double(grayIm(a,b));
						end
					end
				end
			end
		end

		laplacians{k} = laplacian;
	end

end