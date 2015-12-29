function performPreprocessing(directory, trainingFolderName, testingFolderName)
trainingFolderName = strcat('\', trainingFolderName);
testingFolderName = strcat('\', testingFolderName);
trainingDirectory = strcat(directory, trainingFolderName);
testingDirectory = strcat(directory, testingFolderName);
cd(trainingDirectory);
mkdir('Preprocessing');
cd(trainingDirectory);
images = dir('*.jpg');
for i = 1:numel(images)
    filename = images(i).name;
    I = imread(filename);
    sprintf('Performing preprocessing on image %d...\n', i)
    J = multi_scale_self_quotient_image(I);
    J = imadjust(J/255,[min(min(J/255)) max(max(J/255))], [0 1]);
    sprintf('Done\n')
    cd(strcat(trainingDirectory, '\Preprocessing'));
    imwrite(J, filename);
    cd(trainingDirectory);
end
cd(testingDirectory);
mkdir('Preprocessing');
cd(testingDirectory);
images = dir('*.jpg');
for i = 1:numel(images)
    filename = images(i).name;
    I = imread(filename);
    sprintf('Performing preprocessing on images %d...\n', i)
    J = multi_scale_self_quotient_image(I);
    J = imadjust(J/255, [min(min(J/255)) max(max(J/255))], [0 1]);
    sprintf('Done\n');
    cd(strcat(testingDirectory, '\Preprocessing'));
    imwrite(J, filename);
    cd(testingDirectory);
end