clear all;
clc;

% Read the image
f = imread('pout.tif');
f = double(f);

% Get the size of the image
[row, col] = size(f);

% Get user input for lower and upper thresholds
LT = input("Enter the lower threshold value: ");
UT = input("Enter the upper threshold value: ");

% Initialize the output image
g = zeros(row, col);

% Perform contrast stretching
for x = 1:row
    for y = 1:col
        if f(x, y) <= LT
            g(x, y) = 0.5 * f(x, y);
        elseif f(x, y) <= UT
            g(x, y) = 2 * (f(x, y) - LT) + 0.5 * LT;
        else
            g(x, y) = 0.5 * (f(x, y) - UT) + 0.5 * LT + 2 * (UT - LT);
        end
    end
end

% Display the original and contrast-stretched images along with their histograms
subplot(2, 2, 1);
imshow(uint8(f));
title("Original Image");

subplot(2, 2, 2);
imhist(uint8(f));
title("Histogram of Original Image");

subplot(2, 2, 3);
imshow(uint8(g));
title("Image after Contrast Stretching");

subplot(2, 2, 4);
imhist(uint8(g));
title("Histogram of Image after Contrast Stretching");
