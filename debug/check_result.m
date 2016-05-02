%% Multiple result checking

% one = 7;
close all;
% N = randi(normal,1,5);
N = [123,85,42,19,123];
%     N = one * ones(1,5);
    getNplot(N,wav,ORI,RAW,'signal');
    getNplot(N,wav,RAW,DEN2,'signal');
%     getNplot(N,wav,ENERGY,ENERGY,'energy');
% getNplot(N,wav,RAW,DEN2,'FFT');
%% 
close all;
one = randi(artifact,1,1);
% one = 98;

getNplot(one,wav,ENERGY,S1S2,'s1s2');

run check_S1S2;
run check_cycle;

t = wav{one,S1S2}{2,1};
t = new_locs(:,1);
t = cell2mat(t);
d = diff(t);

% Histogram method
[c,h] = hist(d,linspace(0.05,1,20));
[~,S] = sort(c,'descend');
D = abs(wav{one,CYCLE}{2,2} - h(S(1)));

% 2-means methods
[~,SD] = kmeans(d,2);

figure('Position',[0 325 550 150])
plot(d);hold on
plot(h(S(1))*ones(length(d)),'r');
plot(D*ones(length(d)),'b');
if(length(S)>=2)
%     plot(h(S(2))*ones(length(d)),'g');
end
title([wav{one,3},' NO.',num2str(one)])

% plot(SD(1)*ones(length(d)),'r--');
% plot(SD(2)*ones(length(d)),'b--');

figure('Position',[0 100 550 150])
histogram(d,linspace(0.05,1,20));
title([wav{one,3},' NO.',num2str(one)])
display(['std: ',num2str(wav{one,CYCLE}{2,5})]);
