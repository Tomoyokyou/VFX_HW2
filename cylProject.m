function [ img_out ] = cylProject( img_RGB, focalLength, img_cyl_shift  )
img_height = size(img_RGB,1);
img_width = size(img_RGB,2);
img_out = zeros(img_height+img_cyl_shift,img_width+img_cyl_shift,3);
for channel=1:3
    img_channel = img_RGB(:,:,channel);
    %% create coordinate system
    img_cor = zeros(img_height,img_width,3);
    img_cor(:,:,1) = img_channel;
    for i=1:img_width
        img_cor(:,i,2) = i-fix(img_width/2);
    end
    for i=1:img_height
        img_cor(i,:,3) = i-fix(img_height/2);
    end
    img_cyl = zeros(size(img_out,1),size(img_out,2),3);
    for i=1:size(img_cyl,2)
        img_cyl(:,i,2) = i-fix(size(img_cyl,2)/2);
    end
    for i=1:size(img_cyl,1)
        img_cyl(i,:,3) = i-fix(size(img_cyl,1)/2);
    end
    %% reverse warpping
    for i=1:size(img_cyl,1)
        for j=1:size(img_cyl,2)
    % for i=800
    %     for j=1:1200
            % compute x,y
            x = focalLength*tan(img_cyl(i,j,2)/focalLength);
            y = img_cyl(i,j,3)*sqrt(x^2+focalLength^2)/focalLength;
            ix = x+fix(img_width/2);
            iy = y+fix(img_height/2);
            ix_nn = floor(ix);
            iy_nn = floor(iy);
            % in or out
            if(ix_nn>size(img_cor,2)-1) || (ix_nn<1) || (iy_nn>size(img_cor,1)-1) || (iy_nn<1)
                continue;
            end
            % bilinear reconstruct
            img_cyl(i,j,1) = img_cor(iy_nn,ix_nn,1)*(1-ix+ix_nn)*(1-iy+iy_nn)+img_cor(iy_nn,ix_nn,1)*(ix-ix_nn)*(1-iy+iy_nn)+img_cor(iy_nn,ix_nn,1)*(1-ix+ix_nn)*(iy-iy_nn)+img_cor(iy_nn,ix_nn,1)*(ix-ix_nn)*(iy-iy_nn);
        end
    end
    img_out(:,:,channel) = img_cyl(:,:,1); 
end
img_out = uint8(img_out);


