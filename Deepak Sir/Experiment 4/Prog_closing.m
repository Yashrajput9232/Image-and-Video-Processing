% Program for Closing 
% Closing means Dilate first and Erode later

clear all
clc

a = imread('coins.png');
a = double(a);
p = size(a);
w = [1 1 1; 1 1 1; 1 1 1]; % Structuring element 

% Perform Dilation
for x = 2:p(1)-1
    for y = 2:p(2)-1
        % Extract a 3x3 neighborhood
        al = [w(1)*a(x-1,y-1) w(2)*a(x-1,y) w(3)*a(x-1,y+1) ...
              w(4)*a(x,y-1)   w(5)*a(x,y)   w(6)*a(x,y+1) ...
              w(7)*a(x+1,y-1) w(8)*a(x+1,y) w(9)*a(x+1,y+1)];
        % Perform Dilation (maximum value in the neighborhood)
        A1(x,y) = max(al);
    end
end

% Display the result after Dilation
subplot(131)
imshow(uint8(a))
title('Original Image')

subplot(132)
imshow(uint8(A1))
title('Image After Dilation')

% Perform Erosion
q = size(A1);
for x = 2:q(1)-1
    for y = 2:q(2)-1
        % Extract a 3x3 neighborhood from the dilated image
        al1 = [w(1)*A1(x-1,y-1) w(2)*A1(x-1,y) w(3)*A1(x-1,y+1) ...
               w(4)*A1(x,y-1)   w(5)*A1(x,y)   w(6)*A1(x,y+1) ...
               w(7)*A1(x+1,y-1) w(8)*A1(x+1,y) w(9)*A1(x+1,y+1)];
        % Perform Erosion (minimum value in the neighborhood)
        A2(x,y) = min(al1);
    end
end

% Display the result after Erosion
subplot(133)
imshow(uint8(A2))
title('Image After Erosion')
