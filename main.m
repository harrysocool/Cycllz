clear, clc
ORI = 4;
RAW = 5;
DEN2 = 7;
ENERGY = 9;
CYCLE = 11;
S1S2 = 12;
CYCLE2 = 13;
%% parameters for datasetA
decimatedRate = 20;
level = 5;
Fs = 2205;
PATH = './datasetA';

%% parameters for datasetB
% decimatedRate = 4;
% level = 5;
% Fs = 1000;
% PATH = './datasetB';

% load('wav.mat');
run preprocessing;
