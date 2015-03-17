function [all_cluster_imgs] = clustersImage( clusters_array, ims )

	img_size = size(ims{1});

	max_cluster_size = 1;
	all_cluster_imgs = [];
	for i=1:7
		cluster_size = length(clusters_array{i});
		cluster = clusters_array{i};
		cluster_imgs = [];
		
		for j=1:cluster_size
			im = ims{cluster(j)};
			cluster_imgs = [cluster_imgs im];
		end
		
		if(i==1)
			all_cluster_imgs = cluster_imgs;
			max_cluster_size = cluster_size;
			continue;
		end

		if (cluster_size > max_cluster_size)
			horizontal_rectangles = cluster_size - max_cluster_size;
			padding = zeros([size(all_cluster_imgs,1) img_size(2)*horizontal_rectangles 3]);
			all_cluster_imgs = [all_cluster_imgs padding];
			max_cluster_size = cluster_size;
		elseif (cluster_size < max_cluster_size)
			horizontal_rectangles = max_cluster_size - cluster_size;
			padding = zeros([img_size(1) img_size(2)*horizontal_rectangles 3]);
			cluster_imgs = [cluster_imgs padding];
		end 
		all_cluster_imgs = [all_cluster_imgs; cluster_imgs];
	end

end