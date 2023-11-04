function FilteredNoisedSignal = FilterSignal(NoisedSignal, l_frec, u_frec, coef)

    % Применение фильтра Баттерворта
    fs = 1000;  % Частота дискретизации 
    [b, a] = butter(4, [l_frec/ (fs/2), u_frec/ (fs/2)], 'bandpass');
    FilteredNoisedSignal = filtfilt(b, a, NoisedSignal);
end