% Read the original image
originalImage = imread('images.tiff');

% Display the original image
subplot(2, 3, 1)
imshow(originalImage)
title('Original Image')

% Define the motion blur PSF
PSF = fspecial('motion', 21, 11);

% Convert the original image to double precision
originalDouble = im2double(originalImage);

% Apply the motion blur to the original image
blurredImage = imfilter(originalDouble, PSF, 'conv', 'circular');

% Restore the blurred image using Wiener filter
restoredImage = deconvwnr(blurredImage, PSF);

% Display the Original image
subplot(2, 3, 1)
imshow(originalImage)
title('Original Image')

% Display the blurred image
subplot(2, 3, 2)
imshow(blurredImage)
title('Blurred Image')

% Display the restored image after applying Wiener filter
subplot(2, 3, 3)
imshow(restoredImage)
title('Restored Blurred Image')