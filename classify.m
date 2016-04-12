%% Normalise the data
temp = h1;
for j=1:size(temp,2)
    temp(:,j)=temp(:,j)-mean(temp(:,j));
    temp(:,j)=temp(:,j)/std(temp(:,j));
end

%% cross validation
c = cvpartition(label,'HoldOut',0.6);
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

%% Result

% plot(label,'r'); hold on
% plot(nlabel,'b')

tf = testLabel - nlabel;
correctRate = length(find(tf == 0))/size(label,1);
display(['correctRate: ',num2str(correctRate)]);