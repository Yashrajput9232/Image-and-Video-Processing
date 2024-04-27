% Clearing previous variables and command window
clear all;
clc;

% Read the input image
original_image = imread('cameraman.tif');
original_image = double(original_image);

% Get the size of the image
image_size = size(original_image);
N = image_size(1);

% Prompt user to enter the cut-off frequency
cutoff_frequency = input('Enter the cut-off frequency: ');

% Initialize the filter H(u,v)
for u = 1:image_size(1)
    for v = 1:image_size(2)
        D = sqrt((u - (N/2))^2 + (v - (N/2))^2);
        % Define the ideal low pass filter
        if D < cutoff_frequency
            H(u,v) = 1;
        else
            H(u,v) = 0;
        end
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
title('2-D Ideal Low Pass Filter')
subplot(223)
mesh(H)
title('Ideal Low Pass Filter Frequency Response')
subplot(224)
imshow(uint8(filtered_image))
title('Filtered Image')
