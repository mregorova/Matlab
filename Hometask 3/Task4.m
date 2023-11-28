clear; clc; close all;

[signal, fd] = audioread('voice2.wav');

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
xlabel('Hz'); ylabel('|X(n)|'); title('Signal Spec filtered');

[~, idx_ft] = max(abs(signal_filtered_spec(length(signal)/2:end)));
ft = abs(faxis(idx_ft));

% voice tone is about 600.57 Hz

Fs = 2500; % discretization frequency
t = 0:1/Fs:3; %time
f = 600; % sin frequency

x = sin(2*pi*f*t); % sinusoida

audiowrite("mysin.wav", x, Fs);

