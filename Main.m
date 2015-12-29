%**********************************************************
%Generate 50 randomly generated training and testing sets
%from the entire set of data.
%**********************************************************

%for i = 1:50
%    trainingFolderName = strcat('Training', i);
%    testingFolderName = strcat('Testing', i);
%    generate_random_datasets('C:\Users\Tyler\Research\Glasses\Training Testing Sets', 966, 'AllDataSet', ...
%    trainingFolderName, testingFolderName);
%end

%**********************************************************
%Train a SVM classifier for each of the 50 datasets
%**********************************************************
for i = 1:50
    trainingFolderName = strcat('Training', i);
    testingFolderName = strcat('Testing', i);
    performPreprocessing('C:\Users\Tyler\Research\Glasses\Training Testing Sets', trainingFolderName, testingFolderName);
    Y = ones(965, 1);
    Y(140:965) = -1;
    Z = ones(100, 1);
    Z(17:100) = -1;
    filename = 'C:\Users\Tyler\Research\GlassesSVMOutput.txt';
    training_label_vector = cast(Y, 'double');
    testing_label_vector = cast(Z, 'double');
    trainSVMClassifier(training_label_vector, testing_label_vector, ...
    'C:\Users\Tyler\Research\Glasses\Training Testing Sets', ...
    trainingFolderName, testingFolderName, filename');
end