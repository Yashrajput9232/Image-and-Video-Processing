clc;

% Quantization Matrix
quantization_matrix = [
    16, 11, 10, 16, 24;
    12, 12, 14, 19, 26;
    14, 13, 16, 24, 40;
    14, 17, 22, 29, 51;
    18, 22, 37, 56, 68];

% Input Matrix (example)
matrix = [
    255, 255, 0, 255, 255;
    255, 255, 0, 255, 255;
    0, 0, 0, 0, 0;
    255, 255, 0, 255, 255;
    255, 255, 0, 255, 255
];
for i = 1:5
    for j = 1:5
        valid_input = false;
        
        while ~valid_input
            % Prompt user for input
            prompt = sprintf('Enter element at position (%d, %d): ', i, j);
            
            try
                % Attempt to read numeric input
                userInput = input(prompt);
                
                % Check if the input is numeric
                if isnumeric(userInput)
                    matrix(i, j) = userInput;
                    valid_input = true; % Input is valid, exit loop
                else
                    disp('Error: Input must be numeric. Please try again.');
                end
            catch
                disp('Error: Invalid input format. Please try again.');
            end
        end
    end
end
% Perform Discrete Cosine Transform (DCT) on the input matrix
dct_matrix = dct2(matrix);

% Quantization of DCT coefficients
dct_quantized_matrix = dct_matrix ./ quantization_matrix;
dct_quantized_matrix = round(dct_quantized_matrix);

% Encode and decode the quantized matrix using run-length encoding
[encoded, decoded] = runLengthEncodeDecode(dct_quantized_matrix);

% Dequantize the decoded matrix
dequantized_block = decoded .* quantization_matrix;

% Reconstruct the image using Inverse Discrete Cosine Transform (IDCT)
output = idct2(dequantized_block);

% Display results
disp('Input Matrix:')
disp(matrix)
disp('DCT of Input Matrix:')
disp(dct_matrix)
disp('Quantization of the DCT Matrix:')
disp(dct_quantized_matrix)
disp('Encoded:')
disp(encoded);
disp('Decoded:')
disp(decoded);
disp('Dequantization of the Decoded Matrix:')
disp(dequantized_block)
disp('Final Output:')
disp(output)

% Normalize input and output images for display
normalized_matrix = matrix / max(matrix(:));
normalized_output = output / max(output(:));

% Display the input and decoded images side by side
figure;
subplot(1, 2, 1); % First subplot: Input Image
imshow(normalized_matrix);
title('Input Image');

subplot(1, 2, 2); % Second subplot: Decoded Image
imshow(normalized_output);
title('Decoded Image');

% Run-Length Encoding and Decoding Function
function [encoded, decoded] = runLengthEncodeDecode(matrix)
    % Run-Length Encoding
    flattened = matrix(:)';
    n = length(flattened);
    encoded = [];
    count = 1;
    
    for i = 1:n-1
        if flattened(i) == flattened(i+1)
            count = count + 1;
        else
            encoded = [encoded flattened(i) count];
            count = 1;
        end
    end
    encoded = [encoded flattened(end) count];
    
    % Run-Length Decoding
    decoded = [];
    i = 1;
    
    while i <= length(encoded)
        value = encoded(i);
        count = encoded(i+1);
        decoded = [decoded repmat(value, 1, count)];
        i = i + 2;
    end
    
    % Reshape decoded array back into a matrix
    decoded = reshape(decoded, size(matrix));
end
