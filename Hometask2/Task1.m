clear; clc; close all;

[signal, frec] = audioread('file5.wav');
signal = signal .';     %transpose the received data
n = 1:frec;     %create an array of frequencies

signal_spec = fft(signal);

[max_amp, max_idx] = maxk(signal_spec(2:frec/2), 3);

signal_spec_new = zeros(1, frec, "double");

signal_spec_new(max_idx + 1) = signal_spec(max_idx);   %for frecs less than 0
signal_spec_new(frec - max_idx) = signal_spec(max_idx);

signal_new = ifft(signal_spec_new);

fprintf("Main frequencies: %.2ld %.2ld %.2ld Hz\n", max_idx(1), max_idx(2), max_idx(3));

axis = linspace(-frec/2, frec/2, length(signal));

figure;
plot(n, signal)
xlabel('n'); ylabel('X(n)'); title('Signal');

figure;
plot(n, abs(signal_new))
xlabel('n'); ylabel('X(n)'); title('Signal filtered');

figure;
plot(axis, fftshift(abs(signal_spec)))
xlabel('n'); ylabel('X(n)'); title('Signal spectrum');

figure;
plot(axis, fftshift(abs(signal_spec_new)))
xlabel('n'); ylabel('X(n)'); title('Signal filtered spectrum');