function FFT = getFFT(w,Fs)
    HNFFT = floor(size(w,1)/2);
    NFFT = 2*HNFFT;

    f = Fs/2*linspace(0,1,HNFFT);
    Y = fft(w,NFFT)/NFFT;
    Y = 2*abs(Y(1:HNFFT));
    FFT(1,:) = {'Frequency','Amplitude'};
    FFT(2,1) = {f'};
    FFT(2,2) = {Y};
end