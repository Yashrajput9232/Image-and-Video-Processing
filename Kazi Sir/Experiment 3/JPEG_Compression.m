clc;
try
    % Display menu to select input type
    fprintf('Choose the input type:\n');
    fprintf('1. 4x4 Binary Matrix\n');
    fprintf('2. Image File\n');
    choice = input('Enter your choice (1 or 2): ');
    
    if choice == 1
        % Option 1: Input a 4x4 binary matrix
        fprintf('Enter a 4x4 binary matrix (0s and 1s):\n');
        binary_matrix = input('');  % Prompt user to input the binary matrix
        
        % Validate input dimensions
        if ~isequal(size(binary_matrix), [4, 4])
            error('Invalid matrix dimensions. Please provide a 4x4 matrix.');
        end
        
        % Validate binary values (0s and 1s)
        if ~all(binary_matrix(:) == 0 | binary_matrix(:) == 1)
            error('Invalid matrix values. Please provide a matrix of 0s and 1s.');
        end
        if all(binary_matrix(:) == 0 | binary_matrix(:) == 1)

        else
            error('Invalid matrix values. Please provide a matrix of 0s and 1s.');
        end
        
        % Convert binary matrix to uint8 image (scale to 0-255 range)
        input_image = uint8(binary_matrix) * 255;

        
    elseif choice == 2
        % Option 2: Select an image file
        [filename, pathname] = uigetfile({'*.png;*.jpg;*.jpeg', 'Image Files ( *.jpeg)'}, 'Select an Image File');
        
        % Check if the user canceled the file selection
        if isequal(filename, 0) || isequal(pathname, 0)
            disp('User canceled the operation.');
            return;
        end
        
        % Construct the full path to the selected image file
        input_image_path = fullfile(pathname, filename);
        
        % Open the input image
        input_image = imread(input_image_path);
        
        % Check if the input image is grayscale (convert to RGB for display)
        if ndims(input_image) == 2 %#ok<ISMAT>
            input_image = cat(3, input_image, input_image, input_image);  % Convert to RGB
        end
        
    else
        error('Invalid choice. Please enter 1 or 2.');
    end
    
    % Display the input imagex`
    figure('Position', [100, 100, 1000, 400]);
    
    % Display original image with information
    subplot(2, 2, 1);
    imshow(input_image);
    if choice == 1
        title('Input Binary Image');
        original_size = 4 * 4;  % Size of 4x4 binary matrix (in elements)
    else
        title('Input Image');
        original_info = dir(input_image_path);
        original_size = original_info.bytes;  % Size of original image file
    end
    axis off;
    
    % Resize the image
    [height, width, ~] = size(input_image);
    new_size = [height/2, width/2];
    resized_image = imresize(input_image, new_size);
    
    % Save the resized image
    if choice == 1
        output_image_path = 'compressed_binary_image.jpg';
    else
        [~, name, ext] = fileparts(input_image_path);
        output_image_path = fullfile(pathname, ['compressed_' name ext]);
    end
    imwrite(resized_image, output_image_path, 'Quality', 50);
    
    % Display the compressed image
    subplot(2, 2, 2);
    imshow(resized_image);
    title('Compressed Image');
    axis off;
    

    subplot(2,2,4)
    imhist(resized_image)
    title('Histogram Equalisation of Compressed')

    subplot(2,2,3)
    imhist(input_image)
        title('Histogram Equalisation of Input')


    % Get compressed image size and calculate compression ratio
    compressed_info = dir(output_image_path);
    if choice ==2
    compressed_size = compressed_info.bytes;  % Size of compressed image file
    else
        compressed_size = 2*2;
    end
    compression_ratio = (1 - compressed_size/original_size) * 100   ;
    

    fprintf('Original Size: %d bytes\n', original_size);
    fprintf('Compressed Size: %d bytes\n', compressed_size);
    fprintf('Compression Ratio: %.2f%%\n', (1 - compressed_size/original_size) * 100);
catch ME
    % Error Handling
    fprintf('Error: %s\n', ME.message);
end
