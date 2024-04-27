% Read the original image
originalImage = imread("images.tiff");

% Perform histogram equalization
equalizedImage = histeq(originalImage);
figure(1)
% Display the original image and its histogram
subplot(2,2,1), imshow(originalImage);
title('Original Image');
subplot(2,2,2), imhist(originalImage);
title('Original Histogram');

% Display the equalized image and its histogram
subplot(2,2,3), imshow(equalizedImage);
title('Equalised Image');
subplot(2,2,4), imhist(equalizedImage);
title('Equalised Histogram');

% Open a separate figure to allow interactive exploration of the original image
%figure(2)
%imageViewer(originalImage)
