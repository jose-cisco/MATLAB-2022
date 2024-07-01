%2 สร้าง Datastore
Dataset = imageDatastore('test', 'IncludeSubfolders',true,'LabelSource','foldernames');
[Training_Dataset,Validation_Dataset] = splitEachLabel(Dataset, 0.8, 'randomized');

%3 train & test
countlabel = Dataset.countEachLabel;
aa = read(Dataset);
size(aa)

%4 สร้าง CNN 
layers = [imageInputLayer([48 48 1])
convolution2dLayer(3,8,'Padding','same')
batchNormalizationLayer
reluLayer
maxPooling2dLayer(2,'Stride',2)
convolution2dLayer(3,16,'Padding','same')
batchNormalizationLayer
reluLayer
maxPooling2dLayer(2,'Stride',2)
convolution2dLayer(3,32,'Padding','same')
batchNormalizationLayer
reluLayer
fullyConnectedLayer(7)
softmaxLayer
classificationLayer];

%5
options = trainingOptions('sgdm','InitialLearnRate',0.01,'MaxEpochs',10,'Shuffle','every-epoch','ValidationFrequency',10,'Verbose',false,'Plots','training-progress');

%6 training 
convnet = trainNetwork(Training_Dataset,layers,options);

%7 คํานวณความถูกต้องของโมเดลด้วย validate dataset
YPred = classify(convnet,Validation_Dataset);
YValidation = Validation_Dataset.Labels;
accuracy = sum(YPred == YValidation) / numel(YValidation);

%8
plotconfusion(YValidation,YPred)

%9
a = read(Validation_Dataset);
class = classify(convnet,a);
imshow(a)
title(string(class))

%10
clear camera
figure
camera = webcam(1);
while true
im = camera.snapshot;
picture=rgb2gray(im); % Take a picture
picture = imresize(picture,[48,48]); % Resize the picture
label = classify(convnet, picture); % Classify the picture
image(im); % Show the picture
title(char(label)); % Show the label
drawnow;
end

