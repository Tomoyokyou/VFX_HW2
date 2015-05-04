function [ img_blended ] = poissonBlend( img, gradient_H, gradient_V, weight );
%% parameter
itr = 1024;
th = 1E-3;
K=[0,1,0;
   1,0,1;
   0,1,0];
%%
p = ( weight > 0 );
lap = circshift(gradient_H,[0,1]) + circshift(gradient_V,[1,0]) - gradient_H - gradient_V;
err0 = 1E32;
img_blended = img;
img_blended0 = img_blended;
for i = 1:itr
 lpf = imfilter(img_blended,K,'replicate');
 img_blended(p) = (lap(p) + lpf(p))/4;
 
 dif = abs(img_blended-img_blended0);
 err = max(dif(:));
 
 if( (err0 - err)/err0 < th )
    break;
 end
 img_blended0 = img_blended;
 err0 = err;
end

