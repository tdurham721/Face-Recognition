function [features] = extract_features(I)
if size(I,3) == 3
    I = rgb2gray(I); %Convert image to grayscale if it is RGB
end
%J = edge(I, 'sobel', 0.09);
%[rows cols] = size(I);
%avg_pixel = int32(0);
%avg_sobel_pixel = int32(0);
%for i = 1:rows
    %for j = 1:cols
        %avg_pixel = avg_pixel + int32(I(i,j));
        %avg_sobel_pixel  = avg_sobel_pixel + int32(J(i,j));
    %end
%end

%avg_pixel = avg_pixel / (rows * cols);
%avg_sobel_pixel = avg_sobel_pixel / (rows * cols);
hog_features = hog_feature_vector(I);

%features = [avg_pixel avg_sobel_pixel hog_features];
features = [hog_features];