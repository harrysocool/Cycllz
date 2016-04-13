%% Multiple result checking

% one = 7;
close all;
N = randi(all,1,5);
    N = one * ones(1,5);
    getNplot(N,wav,ORI,RAW,'signal');
%     getNplot(N,wav,RAW,DEN2,'signal');
%     getNplot(N,wav,ENERGY,ENERGY+1,'energy');
% getNplot(N,wav,ENERGY,S1S2,'s1s2');
%% 
close all;
one = randi(all,1,1);
% one = 119;

getNplot(one,wav,ENERGY,S1S2,'s1s2');

run check_S1S2;
run check_cycle;

t = wav{one,S1S2}{2,1};
t = cell2mat(t);
d = diff(t);

% Histogram method
[c,h] = hist(d,linspace(0.2,1,20));
[~,S] = sort(c,'descend');
D = abs(wav{one,CYCLE}{2,2} - h(S(1)));

% 2-means methods
[~,SD] = kmeans(d,2);

figure('Position',[0 325 550 150])
plot(d);hold on
plot(h(S(1))*ones(length(d)),'r');
plot(D*ones(length(d)),'b');
if(length(S)>=2)
    plot(h(S(2))*ones(length(d)),'g');
end

plot(SD(1)*ones(length(d)),'r--');
plot(SD(2)*ones(length(d)),'b--');

figure('Position',[0 100 550 150])
histogram(d,linspace(0.2,1,20));
display(wav{one,CYCLE}{2,2});
