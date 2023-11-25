clear; clc; close all;

%% Task 1

SignalSpec = zeros(1, 128);

N = 1:128;

SignalSpec(5) = 1;
SignalSpec(10) = 2;
SignalSpec(60) = 3; %max frequency, по т Котельникова частота дискретизации должна быть около 120 у.е.

Signal = ifft(SignalSpec, 128);

Signal_re = real(Signal);
Signal_im = imag(Signal);

Signal_re_spec = fft(Signal_re);
Signal_im_spec = fft(Signal_im);

figure;
plot(N, abs(Signal))
xlabel('Time'); ylabel('Amplitude'); title('Signal modulus');

%% Task 2

SNR = 37;
[NoisedSignal, Noise] = NoiseGenerator(Signal, SNR);

%% Task 3

P_Signal = PowerSignal(Signal);
P_Noise = PowerSignal(Noise);
P_NoisedSignal = PowerSignal(NoisedSignal);

SNR_analyt = 10*log10(P_Signal/P_Noise);

%% Task 4

NoiseSpec = fft(Noise);
NoisedSignalSpec = fft(NoisedSignal);

P_SignalSpec = PowerSignal(SignalSpec) / 128;
P_NoiseSpec = PowerSignal(NoiseSpec) / 128;
P_NoisedSignalSpec = PowerSignal(NoisedSignalSpec) / 128;

if ((P_SignalSpec - P_Signal)/P_Signal < 1e-5) && ((P_Noise - P_NoiseSpec)/P_Noise < 1e-5) && ((P_NoisedSignal - P_NoisedSignalSpec)/P_NoisedSignal < 1e-5)
    fprintf('TRUE\n')
else
    fprintf('FALSE\n')
end

%% Task 5

%FilteredNoisedSignal = FilterSignal0(NoisedSignal, 15, 55, 1);
FilteredNoisedSignal = FilterSignal(NoisedSignal, 15, 55, 12);

%% Task 6

P_FilteredNoisedSignal = PowerSignal(FilteredNoisedSignal);

SNR_noised = 10*log10(P_Signal / P_Noise);
SNR_filtered = 10*log10(P_Signal / PowerSignal(FilteredNoisedSignal - Signal));

Sum = 0;
for itter = 1 : 50
    rng(itter)
    [NoisedSignal_i, Noise_i] = NoiseGenerator(Signal, SNR);
    FilteredNoisedSignal_i = FilterSignal0(NoisedSignal_i, 15, 55, 12);
    
    P_NoisedSignal_i = PowerSignal(NoisedSignal_i);
    P_FilteredNoisedSignal_i = PowerSignal(FilteredNoisedSignal_i);
    P_Noise_i = PowerSignal(Noise);

    SNR_noised_i = 10*log10(P_NoisedSignal_i / P_Noise_i);
    SNR_filtered_i = 10*log10(P_FilteredNoisedSignal_i / PowerSignal(FilteredNoisedSignal_i - Signal));

    Sum = Sum + SNR_filtered_i - SNR_noised_i;
end
Average_delta = Sum / itter;

%% Dependence delta ~ SNR

x_SNR = -30 : 29;
delta(1:60) = 0;
for itter = 1 : 60
    rng(SNR)
    [NoisedSignal_i, Noise_i] = NoiseGenerator(Signal, x_SNR(itter));
    FilteredNoisedSignal_i = FilterSignal(NoisedSignal_i, 15, 55, 12);

    P_Noise_i = PowerSignal(Noise_i);

    SNR_noised_i = 10*log10(P_Signal / P_Noise_i);
    SNR_filtered_i = 10*log10(P_Signal / PowerSignal(FilteredNoisedSignal_i - Signal));

    delta(itter) = SNR_filtered_i - SNR_noised_i;
end

figure;
plot(x_SNR, delta);
xlabel('SNR'); ylabel('SNR filtered[i] - SNR noised[i]'); 
title('Dependence delta');

fprintf("Gragh demostrates that SNR filtered is worse than SNR noised(((\n");