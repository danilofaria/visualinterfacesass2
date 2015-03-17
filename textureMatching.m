function [matching] = textureMatching( histogram1, histogram2, rows, columns )
	keys1 = histogram1.keys();
	keys2 = histogram2.keys();

	keys= union(keys1,keys2);

	numberOfKeys = size(keys);
	numberOfKeys = numberOfKeys(2);

	L1 = 0;

	for i=1:numberOfKeys
		key = keys{i};

		val1 = 0;
		val2 = 0;
		
		if histogram1.isKey(key)
			val1 = histogram1(key);
		end
		
		if histogram2.isKey(key)
			val2 = histogram2(key);
		end
		
		dif = abs(val1 - val2);
		
		L1 = L1 + dif;
	end

	biggestDif = rows*columns*2;
	matching = 1-L1/biggestDif;
end