%Advanced ML

% dataset A
% 1-49 artifact 40
% 41-59 extrahls 19
% 60-93 murmur 34
% 94-124 normal 31

% load wav_A.mat
%% parameters
T=10;
samp_Num=124;
% dict_Size=50;
rateTr=0.7;
label=label(1:samp_Num);

accuracies=ones(T,1);
accuracies_means=ones(1,15);
accuracies_all_size=ones(10,15);
%% Original feature
%{
Features:
1.column 8: DEN2FFT(400)
2.column 7: waveletDEN2(2000)
3.histogram-h1(20)
4.column 9: shannon energy 1 (80)
5.column 10: shannon energy 2 (2000)
%}

AllFeat=ones(samp_Num,22);
for r_num=2:samp_Num+1  
    c_num1=2;
    c_num2=11;
    AllFeat(r_num-1,1:22)=h1(r_num-1,1:22);
%     AllFeat(r_num-1,1:400)=wav{r_num,c_num1}{2,2}(1:400)';  
%     AllFeat(r_num-1,401:2400)=wav{r_num,c_num2}{2,2}(1:2000)';
%     AllFeat(r_num-1,2401:2420)=h1(r_num-1,[1:18 21:22]);
%     AllFeat(r_num-1,2421:2500)=wav{r_num,c_num2}{2,2}(1:80)';
%     AllFeat(r_num-1,2501:4500)=wav{r_num,c_num2}{2,2}(1:2000)';
end
AllFeat=[AllFeat label(1:samp_Num,:)];

% Normalize
for j=1:size(AllFeat,2)-1
    AllFeat(:,j)=AllFeat(:,j)-mean(AllFeat(:,j));
    AllFeat(:,j)=AllFeat(:,j)/std(AllFeat(:,j));
end

for dict_Size=10:10:150 % loop size to find best size of dictionary
%% main loop
for t=1:T % time loop

index1=randperm(40);
index2=randperm(19)+40;
index3=randperm(34)+59;
index4=randperm(31)+93;

rng_Tr_1=1:round(rateTr*40);
rng_Tr_2=1:round(rateTr*19);
rng_Tr_3=1:round(rateTr*34);
rng_Tr_4=1:round(rateTr*31);

rng_Ts_1=1+round(rateTr*40):40;
rng_Ts_2=1+round(rateTr*19):19;
rng_Ts_3=1+round(rateTr*34):34;
rng_Ts_4=1+round(rateTr*31):31;

FFTFeat_Tr=[AllFeat(index1(rng_Tr_1),:);...
    AllFeat(index2(rng_Tr_2),:);...
    AllFeat(index3(rng_Tr_3),:);...
    AllFeat(index4(rng_Tr_4),:)];...
LTrain=size(FFTFeat_Tr,1);

FFTFeat_Ts=[AllFeat(index1(rng_Ts_1),:);...
    AllFeat(index2(rng_Ts_2),:);...
    AllFeat(index3(rng_Ts_3),:);...
    AllFeat(index4(rng_Ts_4),:)];...
LTest=size(FFTFeat_Ts,1);

%% Bag of Visual Words (train)
word_Num=8;
word_Len=1;
BoVW_Tr=ones(LTrain*word_Num,word_Len+1);
for i=1:LTrain
    for j=1:word_Num
        BoVW_Tr((i-1)*word_Num+j,1:end-1)=...
            FFTFeat_Tr(i,(j-1)*word_Len+1:j*word_Len);
    end
end

%% dictionary
[index_BoVW,dict]=kmeans(BoVW_Tr,dict_Size);

%% description
words=ones(word_Num,word_Len);% container
index=ones(word_Num,1);% container

featVec_Tr=ones(LTrain,dict_Size+1);
featVec_Ts=ones(LTest,dict_Size+1);

for i=1:LTrain
    for k=1:word_Num
        words(k,:)=FFTFeat_Tr(i,(k-1)*word_Len+1:k*word_Len);
    end

    [index, ~] = knnsearch(dict(:,1:end-1), words, 'K', 1);
    featVec_Tr(i,1:end-1) = histc(index', 1:dict_Size);
    featVec_Tr(i,end) = FFTFeat_Tr(i,end);
end
for i=1:LTest
    for k=1:word_Num
        words(k,:)=FFTFeat_Ts(i,(k-1)*word_Len+1:k*word_Len);
    end

    [index, ~] = knnsearch(dict(:,1:end-1), words, 'K', 1);
    featVec_Ts(i,1:end-1) = histc(index', 1:dict_Size);
    featVec_Ts(i,end) = FFTFeat_Ts(i,end);
end

%% train SVM
SVM_Model = fitcecoc(featVec_Tr(:,1:end-1),featVec_Tr(:,end),...
    'Coding','onevsone','Learners','svm');
pred_label = predict(SVM_Model,featVec_Ts(:,1:end-1));

%% Accuracy
accuracy=calAccuracy(pred_label,featVec_Ts(:,end));
accuracies(t)=accuracy;

%% plot comparison
% figure(t),clf
% xx1=1:LTest;
% plot(xx1,featVec_Ts(:,end),'b');
% hold on
% plot(xx1,pred_label,'r');
% grid on
% grid minor
% hold off

end % end of time loop

%% mean of accuracy
accuracies_mean=mean(accuracies);
accuracies_means(:,dict_Size/10)=accuracies_mean;
accuracies_all_size(:,dict_Size/10)=accuracies;

end % end of find size loop





