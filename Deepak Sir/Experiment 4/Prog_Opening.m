% Program for Opening
% Opening means Erode first and Dilate later

% Clearing previous variables and command window
clear all
clc
% Read the input image
a = imread('bot.png');
a = double(a);
% Define the size of the image
p = size(a);
% Define the structuring element
w = [1 1 1; 1 1 1; 1 1 1]; 
% Perform Erosion
for x = 2:p(1)-1
    for y = 2:p(2)-1
        % Extract a 3x3 neighborhood
        neighborhood = [w(1)*a(x-1,y-1) w(2)*a(x-1,y) w(3)*a(x-1,y+1) ...
                        w(4)*a(x,y-1)   w(5)*a(x,y)   w(6)*a(x,y+1) ...
                        w(7)*a(x+1,y-1) w(8)*a(x+1,y) w(9)*a(x+1,y+1)];
        % Perform Erosion (minimum value in the neighborhood)
        A1(x,y) = min(neighborhood);
    end
    % Display the result after Erosion
    subplot(131)
    imshow(a)
    title('Original Image')

    subplot(132)
    imshow(A1)
    title('Image After Erosion')
end
% Define the size of the eroded image
q = size(A1);
% Perform Dilation
for x = 2:q(1)-1
    for y = 2:q(2)-1
        % Extract a 3x3 neighborhood from the eroded image
        neighborhood_dilation = [w(1)*A1(x-1,y-1) w(2)*A1(x-1,y) w(3)*A1(x-1,y+1) ...
                                 w(4)*A1(x,y-1)   w(5)*A1(x,y)   w(6)*A1(x,y+1) ...
                                 w(7)*A1(x+1,y-1) w(8)*A1(x+1,y) w(9)*A1(x+1,y+1)];
        % Perform Dilation (maximum value in the neighborhood)
        A2(x,y) = max(neighborhood_dilation);
    end
end
% Display the result after Dilation
subplot(133)
imshow(A2)
title('Image After Dilation')
