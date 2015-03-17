function [difs] = part2( )

	% number of images
	nImages = 40;

	% load images and compute laplacians
	[ims, laplacians, labeled_ims] = imgsAndLaplacians(nImages);

	% compute dimensions of images
	im = ims{1};
	[rows, columns, colors] = size(im);

	% compute all histograms
	histograms = computeTextureHistogram(laplacians, nImages);

	% compute the difs matrix (similarities)
	difs = zeros(nImages,nImages);
	for i=1:nImages
		for j=i:nImages
			if (i==j) 
				difs(i,j) = 1;
				continue;
			else
				dif = textureMatching( histograms{i}, histograms{j}, rows, columns);
				difs(i,j) = dif;
				difs(j,i) = dif;
			end
		end
	end

	% sort by similarity
	[difs_sorted difs_index] = sort(difs);

	% keep only 3 most similar and 3 most dissimilar
	difs_index = [difs_index(1:3,:); difs_index(nImages-2-1:nImages-1,:)];

	% generate image table with results and save it in two halves
	result_image = []
	for j=1:(nImages/2)
		result_row = [labeled_ims{j} labeled_ims{difs_index(6,j)} labeled_ims{difs_index(5,j)} labeled_ims{difs_index(4,j)} labeled_ims{difs_index(1,j)} labeled_ims{difs_index(2,j)} labeled_ims{difs_index(3,j)}];
		if j==1
			result_image = result_row;
		else
			result_image = [result_image; result_row];
		end
	end
	imwrite(result_image,'part2/part2_1.png');
	result_image = []
	for j=(nImages/2+1):nImages
		result_row = [labeled_ims{j} labeled_ims{difs_index(6,j)} labeled_ims{difs_index(5,j)} labeled_ims{difs_index(4,j)} labeled_ims{difs_index(1,j)} labeled_ims{difs_index(2,j)} labeled_ims{difs_index(3,j)}];
		if j==1
			result_image = result_row;
		else
			result_image = [result_image; result_row];
		end
	end
	imwrite(result_image,'part2/part2_2.png');

	% compute 4 most alike and 4 most unalike images
	most_alike = fourMostAlike( difs, nImages );
	most_unalike = fourMostUnalike( difs, nImages );
	% Display and save them
	alike_imgs = []
	unalike_imgs = []
	for i=1:4
		alike_imgs = [alike_imgs labeled_ims{most_alike(i)}];
		unalike_imgs = [unalike_imgs labeled_ims{most_unalike(i)}];
	end
	f=figure
	subplot(2,1,1);
	imshow(alike_imgs);
	title('Four most alike images in texture');
	subplot(2,1,2);
	imshow(unalike_imgs);
	title('Four most unalike images in texture');

	saveas(f,'part2/fourmost_texture.png');
	
end