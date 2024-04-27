% Clearing previous variables and command window
clear all;
clc;

% Read the input image
original_image = imread('cameraman.tif');
original_image = double(original_image);

% Get the size of the image
image_size = size(original_image);
N = image_size(1);

% Prompt user to enter the order and cut-off frequency of the filter
n = input('Enter the order of the filter: ');
DO = input('Enter the cut-off frequency: ');

% Initialize the filter H(u,v)
for u = 1:image_size(1)
    for v = 1:image_size(2)
        D = sqrt((u - (N/2))^2 + (v - (N/2))^2);
        H(u,v) = 1 / (1 + (D / DO)^(2 * n));
    end
end

% Perform FFT on the input image
fft_image = fft2(original_image);
fft_shifted_image = fftshift(fft_image);

% Apply the filter in the frequency domain
filtered_image_fft = fft_shifted_image .* H;

% Perform inverse FFT to get the filtered image
filtered_image = abs(ifft2(filtered_image_fft));

% Displaying the original image, filter, frequency response, and filtered image
subplot(221)
imshow(uint8(original_image))
title('Original Image')

subplot(222)
imagesc(H), colormap(gray)
title('2-D Butterworth Low Pass Filter')

subplot(223)
mesh(H)
title('Butterworth Low Pass Filter Frequency Response')

subplot(224)
imshow(uint8(filtered_image))
title(['Filtered Image with Cut-off = ' num2str(DO) ', Order = ' num2str(n)])
