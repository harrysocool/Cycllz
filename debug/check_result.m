%% Multiple result checking

% one = 7;
close all;
N = randi(all,1,5);
%     N = one * ones(1,5);
%     getNplot(N,wav,RAW,DEN2,'FFT');
%     getNplot(N,wav,RAW,DEN2,'signal');
    getNplot(N,wav,ENERGY,ENERGY+1,'energy');
% getNplot(N,wav,ENERGY,S1S2,'s1s2');
%%
close all;
one = randi(murmur,1,1);
% one = 119;

getNplot(one,wav,ENERGY,S1S2,'s1s2');

run check_S1S2;
run check_cycle;

t = wav{one,S1S2}{2,1};
t = cell2mat(t);
d = diff(t);

figure('Position',[0 325 550 150])
plot(d);
figure('Position',[0 100 550 150])
histogram(d,[0:0.1:2]);
display(wav{one,CYCLE}{2,2});
