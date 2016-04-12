clear a;
a = hist;
for j=1:size(a,2)
    a(:,j)=a(:,j)-mean(a(:,j));
    a(:,j)=a(:,j)/std(a(:,j));
end
%%

net = feedforwardnet(20);
net = train(net,a',label');

for j = 1:size(a,1)
     temp = net(a(j,:)');
     nlabel(j,1) = round(temp);
end
%%
model = fitcecoc(a,label,'Coding','onevsone');
nlabel = predict(model,a);

%%

plot(label,'r'); hold on
plot(nlabel,'b')