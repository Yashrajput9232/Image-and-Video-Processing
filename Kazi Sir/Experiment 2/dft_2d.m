% IVP Lab – Experiment No: 2 – 2D DFT
% Yash Rajput – TY EC - 211060042

myArray = [];
disp('Entered output will be in this manner')
disp('[1 5 9  13]')
disp('[2 6 10 14]')
disp('[3 7 11 15]')
disp('[4 8 12 16]')
disp('Enter 16 numeric elements to append to the array:');

while length(myArray) < 16
    % Prompt the user for input
    userInput = input('Enter a numeric element: ', 's');
    
    % Convert the input to a number (if possible)
    numInput = str2double(userInput);
    
    % Check if the input is a valid number
    if ~isnan(numInput)
        % Append the number to the array
        myArray(end+1) = numInput;
        disp(['Element ', num2str(length(myArray)), ' added to the array.']);
    else
        disp('Invalid input. Please enter a valid numeric number.');
    end
end

matrix = reshape(myArray, 4, 4);
disp('Original Matrix:');
disp(matrix);
disp('Press 1 for Discrete Fourier Transform (DFT)')
disp('Press 2 for Discrete Cosine Transform (DCT)')
disp('Press 3 for Wavelet Transform')
choice = input('Enter your choice: ');

if choice == 1
% DFT
    type = 'DFT of Matrix';
    transformed_matrix = fft2(matrix);
elseif choice == 2
% DCT
    type = 'DCT of Matrix';
    transformed_matrix = round(dct2(matrix),1);
elseif choice == 3
% Wavelet Transform
    type = 'Wavelet Transform of Matrix';
    [c,s] = wavedec2(matrix, 2, 'db1');
     c = transformed_matrix;
else
    disp('Invalid Choice')
end 
% Display the original matrix and its DFT
disp('Original Matrix:');
disp(matrix);
disp(type);
disp(transformed_matrix);

subplot(2,1,1)
imshow(matrix, []);
colormap(gray);
title('Original Matrix');

subplot(2,1,2)
imshow(abs(transformed_matrix), []);
colormap(gray);
title(type);


