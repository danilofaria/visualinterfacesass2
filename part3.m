function [complete_clusters, single_clusters] = part3( )
	
	% number of images
	nImages = 40;

	% load images and compute laplacians
	[ims, laplacians, labeled_ims] = imgsAndLaplacians(nImages);

	% compute dimensions of images
	im = ims{1};
	[rows,columns,colors] = size(im);

	% compute all histograms
	colorHistograms = computeColorHistogram(ims, nImages);
	textureHistograms = computeTextureHistogram(laplacians, nImages);

	% compute the difs matrix (similarities)
	difs = zeros(nImages,nImages);
	for i=1:nImages
		for j=i:nImages
			if (i==j) 
				difs(i,j) = 1;
				continue;
			else
				dif = computeSimilarity( colorHistograms{i}, colorHistograms{j}, textureHistograms{i}, textureHistograms{j}, rows, columns);

				difs(i,j) = dif;
				difs(j,i) = dif;
			end
		end
	end

	clusters_closeness = 1-difs;

	% number of clusters
	k=7;

	% compute clusters
	complete_linkage = linkage(clusters_closeness, 'complete');
	single_linkage = linkage(clusters_closeness, 'single');
	complete_clusters = cluster(complete_linkage, 'maxclust', k);
	single_clusters = cluster(single_linkage, 'maxclust', k);

	% save cluster images
	complete_clusters_array = {}
	single_clusters_array = {}
	for i=1:k
		complete_clusters_array{i} = []
		single_clusters_array{i} = []
	end
	for i=1:nImages
		complete_clusters_array{complete_clusters(i)} = [complete_clusters_array{complete_clusters(i)} i]
		single_clusters_array{single_clusters(i)} = [single_clusters_array{single_clusters(i)} i]
	end
	complete_cluster_imgs = clustersImage(complete_clusters_array, labeled_ims);
	single_cluster_imgs = clustersImage(single_clusters_array, labeled_ims);
	imwrite(complete_cluster_imgs,'part3/complete_cluster_imgs.png');
	imwrite(single_cluster_imgs,'part3/single_cluster_imgs.png');

	% defining color threshold in order for each one of the seven clusters have their own unique color
	complete_threshold = sort(complete_linkage(:,3));
	complete_threshold = complete_threshold(size(complete_linkage,1)+2-k);
	single_threshold = sort(single_linkage(:,3));
	single_threshold = single_threshold(size(single_linkage,1)+2-k);

	% show and save dendograms
	f=figure();
	set(f,'Visible','off');
	dendrogram(complete_linkage,0,'ColorThreshold',complete_threshold);
	title('Complete Link');
	set(f, 'PaperUnits', 'centimeters');
	set(f, 'PaperPosition', [0 0 30 25]);
	saveas(f,'part3/complete_link_dendrogram.png')
	f=figure();
	set(f,'Visible','off');
	dendrogram(single_linkage,0,'ColorThreshold',single_threshold);
	title('Single Link');
	set(f, 'PaperUnits', 'centimeters');
	set(f, 'PaperPosition', [0 0 30 25]);
	saveas(f,'part3/single_link_dendrogram.png')

end
