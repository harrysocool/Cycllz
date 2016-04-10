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
one = randi(extrahls,1,1);
% one = 119;

getNplot(ones(1,3)*one,wav,ENERGY,S1S2,'s1s2');

run check_S1S2;
run check_cycle;