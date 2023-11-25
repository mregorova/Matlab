function FilteredNoisedSignal = FilterSignal(NoisedSignal, freqLow, freqHigh, samplingFrequency)
    % Выполнение FFT для исходного сигнала
    signalSpectrum = fft(NoisedSignal);
    
    % Создание частотной оси
    N = length(NoisedSignal);
    f = (0:N-1)*(samplingFrequency/N);
    
    % Применение фильтра BandPass к спектру сигнала
    passRegion = (f >= freqLow) & (f <= freqHigh);
    signalSpectrumFiltered = signalSpectrum .* passRegion;
    
    % Обратное преобразование Фурье для получения отфильтрованного сигнала
    FilteredNoisedSignal = ifft(signalSpectrumFiltered);
end
