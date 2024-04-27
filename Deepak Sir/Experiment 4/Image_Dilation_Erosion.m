clear all
clc

% Load the image
a = imread('bot.png');
p = size(a);
% Using MATLAB's built-in functions for comparison
s = strel('square', 3);
dilated_matlab = imdilate(a, s);
eroded_matlab = imerode(a, s);
% Implementing dilation and erosion manually
w = [1 1 1; 1 1 1; 1 1 1]; % Structuring element
for x = 2:1:p(1)-1
    for y = 2:1:p(2)-1
        al = [w(1) * a(x-1, y-1) w(2) * a(x-1, y) w(3) * a(x-1, y+1) ...
              w(4) * a(x, y-1)   w(5) * a(x, y)   w(6) * a(x, y+1) ...
              w(7) * a(x+1, y-1) w(8) * a(x+1, y) w(9) * a(x+1, y+1)];
          
        % Dilation
        A1(x, y) = max(al);
        
        % Erosion
        A2(x, y) = min(al);
    end
end

% Plotting
subplot(231)
imshow(a)
title('Original Image')
subplot(232)
imshow(dilated_matlab)
title('Dilation using MATLAB')
subplot(233)
imshow(eroded_matlab)
title('Erosion using MATLAB')
subplot(234)
imshow(A1)
title('Dilation using program')
subplot(235)
imshow(A2)
title('Erosion using program')
