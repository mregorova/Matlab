clear; clc; close all;

[signal, fd] = audioread('voice.wav');

signal(signal==0) = [];
signal = log10(abs(signal));

signal_spec = fft(signal);

signal_filtered = bandpass(signal, [50, 10000], fd);

signal_filtered_spec = fft(signal_filtered);

k = 1 : length(signal);

figure;
plot(k, abs(signal_filtered))
xlabel('n'); ylabel('|X(n)|'); title('Signal');

faxis = linspace(-fd/2, fd/2, length(signal));

figure;
plot(faxis, fftshift(abs(signal_filtered_spec)))
xlabel('k'); ylabel('|X(n)|'); title('Signal Spec (new f axis)');

[~, idx_ft] = max(abs(signal_filtered_spec(length(signal)/2:end)));
ft = abs(faxis(idx_ft));

% voice tone is about 546.85 Hz

