clear, clc
ORI = 3;
RAW = 4;
DEN2 = 6;
ENERGY = 8;
CYCLE = 10;
S1S2 = 11;
CYCLE2 = 12;

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