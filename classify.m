%% Normalise the data
temp = h1;
for j=1:size(temp,2)
    temp(:,j)=temp(:,j)-mean(temp(:,j));
    temp(:,j)=temp(:,j)/std(temp(:,j));
end

for loop = 1:10
%% cross validation
c = cvpartition(label,'HoldOut',0.3);
trIdx = c.training;
teIdx = c.test;

trainData = temp(trIdx,:);
trainLabel = label(trIdx,:);
testData = temp(teIdx,:);
testLabel = label(teIdx,:);

%% Neural Network

% net = feedforwardnet(20);
% net = train(net,trainData',trainLabel');
% 
% for j = 1:size(testData,1)
%      l = net(testData(j,:)');
%      nlabel(j,1) = round(l);
% end
%% SVM
model = fitcecoc(trainData,trainLabel,'Coding','onevsone','Learners','svm');
nlabel = predict(model,testData);

%% Random Forest
opts= struct;
opts.depth= 9;
opts.numTrees= 100;
opts.numSplits= 5;
opts.verbose= true;
opts.classifierID= [2,3]; % weak learners to use. Can be an array for mix of weak learners too

m= forestTrain(trainData, trainLabel, opts);
%%
nlabel = forestTest(m, testData);

%% Result
tf = testLabel - nlabel;
correctRate = length(find(tf == 0))/size(nlabel,1);
display(['correctRate: ',num2str(correctRate)]);
    cR(loop) = correctRate;
end
%%
plot(testLabel,'r'); hold on
plot(nlabel,'b')