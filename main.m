clear, clc
ORI = 4;
RAW = 5;
DEN2 = 7;
ENERGY = 9;
CYCLE = 11;
S1S2 = 12;
CYCLE2 = 13;

% parameters
level = 5;
Fs = 2205;
artifact = [1,40];
extrahls = [41,59];
murmur = [60,93];
normal = [94,124];
testing = [125,176];
all = [1,176];

% load('wav.mat');
run preprocessing;