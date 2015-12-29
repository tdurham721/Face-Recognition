function trainSVMClassifier(training_label_vector, testing_label_vector, directory, trainingFolderName, testingFolderName, fileName)
%**********************************************************
%Initialization
%**********************************************************
training_feature_vector = zeros(size(training_label_vector, 1), 2160);
photometric_training_feature_vector = zeros(size(training_label_vector, 1), 2160);
testing_feature_vector = zeros(size(testing_label_vector, 1), 2160);
photometric_testing_feature_vector = zeros(size(testing_label_vector, 1), 2160);
training_label_vector = [training_label_vector; training_label_vector];
fileID = fopen(fileName, 'a');
trainingFolderName = strcat('\', trainingFolderName);
testingFolderName = strcat('\', testingFolderName);
trainingDirectory = strcat(directory, trainingFolderName);
photometricTrainingDirectory = strcat(trainingDirectory, '\Photometric');
testingDirectory = strcat(directory, testingFolderName);
photometricTestingDirectory = strcat(testingDirectory, '\Photometric');
numTesting = size(testing_label_vector, 1);

%**********************************************************
%Extract the features from the training and testing images
%and store them in their respective feature vectors.
%**********************************************************
cd(trainingDirectory);
images = dir('*.jpg');
for i = 1:numel(images)
    filename = images(i).name;
    I = imread(filename);
    training_feature_vector(i, :) = extract_features(I);
end

cd(photometricTrainingDirectory);
images = dir('*.jpg');
for i = 1:numel(images)
    filename = images(i).name;
    I = imread(filename);
    photometric_training_feature_vector(i, :) = extract_features(I);
end

cd(testingDirectory);
images = dir('*.jpg');
for i = 1:numel(images)
    filename = images(i).name;
    I = imread(filename);
    testing_feature_vector(i, :) = extract_features(I);
end

cd(photometricTestingDirectory);
images = dir('*.jpg');
for i = 1:numel(images)
    filename = images(i).name;
    I = imread(filename);
    photometric_testing_feature_vector(i, :) = extract_features(I);
end

training_feature_vector = cast(training_feature_vector, 'double');
photometric_training_feature_vector = cast(photometric_training_feature_vector, 'double');
training_feature_vector = [training_feature_vector; photometric_training_feature_vector];
testing_feature_vector = cast(testing_feature_vector, 'double');
photometric_testing_feature_vector = cast(photometric_testing_feature_vector, 'double');

%**********************************************************
%Train an SVM classifier for the training data, then
%make predictions about the testing data using a grid search,
%then write the best results to a file.
%**********************************************************
fprintf(fileID, '************TRAINING AND TESTING SET************\r\n');
for powerc = -5:2:15
    for powerg = -15:2:5
        options = sprintf('-s 0 -t 2 -c %d -g %d', 2^powerc, 2^powerg);
        model = svmtrain(training_label_vector, training_feature_vector, options);

        [predicted_label, accuracy1, decision_values_prob_estimates] = svmpredict(testing_label_vector, testing_feature_vector, model);
        [predicted_label, accuracy2, decision_values_prob_estimates] = svmpredict(testing_label_vector, photometric_testing_feature_vector, model);
        accuracy = max(accuracy1(1), accuracy2(1));
        fprintf(fileID, 'GAMMA: 2^%d COST: 2^%d ACCURACY %d/100\r\n', powerg, powerc, accuracy(1));
    end
end
fprintf(fileID, '\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n');
fclose(fileID);
end