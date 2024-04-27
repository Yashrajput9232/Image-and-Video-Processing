clear all
clc

% Define a new 3x3 binary matrix
originalMatrix = [0 0 0;
                  0 1 0;
                  0 0 0];

structuringElement = ones(3); % Structuring element for neighborhood processing

% Initialize result matrices for dilation and erosion
dilatedMatrix = ones(size(originalMatrix)); % Initialize to all white
erodedMatrix = zeros(size(originalMatrix));

for x = 2:size(originalMatrix, 1) - 1
    for y = 2:size(originalMatrix, 2) - 1
        % Extract the neighborhood using the structuring element
        neighborhood = originalMatrix(x-1:x+1, y-1:y+1);
        
        % Apply dilation
        dilatedMatrix(x, y) = max(neighborhood(:));
        
        % Apply erosion
        erodedMatrix(x, y) = min(neighborhood(:));
    end
end

% Display original, dilation, and erosion results in a 1x3 subplot
subplot(1, 3, 1)
imshow(originalMatrix)
title('Original')

subplot(1, 3, 2)
imshow(dilatedMatrix)
title('Dilation')

subplot(1, 3, 3)
imshow(erodedMatrix)
title('Erosion')

% Display matrices
disp('Original Matrix:')
disp(originalMatrix)

disp('Dilated Matrix:')
disp(dilatedMatrix)

disp('Eroded Matrix:')
disp(erodedMatrix)
