% Clearing previous variables and command window
clear all;
clc;

% Read the input image
original_image = imread('cameraman.tif');
original_image = double(original_image); % Convert image to double for calculations

% Get the size of the image
[row, col] = size(original_image);

% Perform dynamic range compression
for x = 1:row
    for y = 1:col
        % Apply the transformation to center the image
        centered_image(x, y) = original_image(x, y) * ((-1)^(x+y));
    end
end

% Compute the magnitude spectrum using FFT
magnitude_spectrum = abs(fft2(centered_image));

% Apply log transformation to enhance visualization
log_magnitude_spectrum = log(1 + magnitude_spectrum);

%%% Plotting %%%

% Plot the magnitude spectrum without log transformation
subplot(2,2,1)
colormap(gray)
imagesc(magnitude_spectrum)
title('Magnitude Spectrum without Log Transformation')

% Plot the magnitude spectrum with log transformation
subplot(2,2,2)
colormap(gray)
imagesc(log_magnitude_spectrum)
title('Magnitude Spectrum with Log Transformation')
