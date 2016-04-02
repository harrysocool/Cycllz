%% Multiple result checking
% one = 7;
for i = 1:1
    N = randi(all,1,5);
%     N = one * ones(1,5);
%     getNplot(N,wav,RAW,DEN2,'FFT');
%     getNplot(N,wav,RAW,DEN2,'signal');
%     getNplot(N,wav,ENERGY,ENERGY+1,'energy');
    getNplot(N,wav,ENERGY,S1S2,'s1s2');
    pause
    close all
end
