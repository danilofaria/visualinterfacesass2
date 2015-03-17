function [index] = randIndex( P1, P2, n )

	% computing the rand index of two set partitions based on
	% http://en.wikipedia.org/wiki/Rand_index
	
	a = 0;
	b = 0;
	c = 0;
	d = 0;

	for i=1:n
		for j=i:n
			
			if (i==j)
				continue;
			end

			P1_same_partition_ij = (P1(i) == P1(j));
			P2_same_partition_ij = (P2(i) == P2(j));

			if (P1_same_partition_ij && P2_same_partition_ij)
				a = a +1;
            elseif (~P1_same_partition_ij && ~P2_same_partition_ij)
				b = b +1;
            elseif (P1_same_partition_ij && ~P2_same_partition_ij)
				c = c + 1;
			else 
				d = d + 1;
		end
	end

	index = (a+b) / (a + b + c + d);

end