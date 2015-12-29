function generate_random_datasets(directory, trainingSize, datasetFolderName, trainingFolderName, testingFolderName)
%**********************************************************
%Initialization of folder names for navigation in the code
%**********************************************************
cd(directory);
mkdir(trainingFolderName);
mkdir(testingFolderName);
datasetFolderName = strcat('\', datasetFolderName);
trainingFolderName = strcat('\', trainingFolderName);
testingFolderName = strcat('\', testingFolderName);
datasetDirectory = strcat(directory, datasetFolderName);
trainingDirectory = strcat(directory,trainingFolderName);
testingDirectory = strcat(directory, testingFolderName);
cd(trainingDirectory);
mkdir('Photometric');
trainingPhotometricDirectory = strcat(trainingDirectory, '\Photometric');
cd(testingDirectory);
mkdir('Photometric');
testingPhotometricDirectory = strcat(testingDirectory, '\Photometric');
cd(datasetDirectory);
images = dir('*.jpg');

%**********************************************************
%Randomize dataset and split into training and testing sets
%**********************************************************
totalImages = randperm(numel(images));
trainingImages = totalImages(1:trainingSize);
testingImages = totalImages((trainingSize + 1):size(totalImages, 2));

%**********************************************************
%Write training and testing sets into their respective
%folders, and apply histogram equalization to the images
%**********************************************************
for i = 1:size(trainingImages,2)
    cd(datasetDirectory);
    filename = images(trainingImages(i)).name;
    I = imread(filename);
    cd(trainingDirectory);
    imwrite(I, filename);
    J = adapthisteq(I);
    cd(trainingPhotometricDirectory);
    imwrite(J, filename);
end
for i = 1:size(testingImages,2)
    cd(datasetDirectory);
    filename = images(testingImages(i)).name;
    I = imread(filename);
    cd(testingDirectory);
    imwrite(I, filename);
    J = adapthisteq(I);
    cd(testingPhotometricDirectory);
    imwrite(J, filename);
end
cd(directory);
end