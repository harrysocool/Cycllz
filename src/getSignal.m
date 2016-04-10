function Time = getSignal(w,Fs)
    i = size(w,1)/Fs;
    T = linspace(0,i,size(w,1));
    Time(1,:) = {'Time','Amplitude'};
    Time(2,1) = {T'};
    Time(2,2) = {w};
end