function [S] = computeSimilarity( colorHistogram1, colorHistogram2, textureHistogram1, textureHistogram2, rows, columns )

	r = 0.2;
	C = colorMatching( colorHistogram1, colorHistogram2, rows, columns);
	T = textureMatching( textureHistogram1, textureHistogram2, rows, columns );
	S = r*T + (1-r)*C;

end