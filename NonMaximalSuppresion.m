function  [Corner.r Corner.c] = NonMaximalSuppresion(R, keypointNum, I)

tempNum = keypointNum+1;
localRadius = max(size(I,1), size(I,2));

while (tempNum>keypointNum&&localRadius>=3)
	localSize = 2*localRadius+1;
	localMax = ordfilt2(R,localSize^2,ones(localSize)); 
	
	
	localRadius = min(round(localRaius/2), 3);
end
