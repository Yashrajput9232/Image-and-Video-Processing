% Clearing previous variables and command window
clear all;
clc;

% Read the input image
original_image = imread('xray2.tiff');
a = double(original_image);

% Get the size of the image
[row, col] = size(a);

% Define the high-pass filter kernel
w = [-1, -1, -1; -1, 8, -1; -1, -1, -1];

% Apply the high-pass filter
for x = 2:row-1
    for y = 2:col-1
        % Convolution operation to apply the high-pass filter
        al(x,y) = w(1)*a(x-1,y-1) + w(2)*a(x-1,y) + w(3)*a(x-1,y+1) ...
                + w(4)*a(x,y-1) + w(5)*a(x,y) + w(6)*a(x,y+1) ...
                + w(7)*a(x+1,y-1) + w(8)*a(x+1,y) + w(9)*a(x+1,y+1);
    end
end

% Displaying the original image and the image after high-pass filtering
figure(1)
subplot(1,2,1)
imshow(uint8(a))
title('Original Image');

subplot(1,2,2)
imshow(uint8(al))
title('Image After Sharpening or High Pass Filtering');
