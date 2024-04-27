% Thinning
% Get the image skeleton.
BW = imread('circles.png');

subplot(131)
imshow(BW);
title('Original Image')

% Remove interior pixels to leave an outline of the shapes.
BW_outline = bwmorph(BW, 'remove'); 
subplot(132)
imshow(BW_outline);
title('Image Outline')

% Get the skeleton of the image.
BW_skeleton = bwmorph(BW, 'skel', Inf);
subplot(133)
imshow(BW_skeleton);
title('Image Skeleton')
