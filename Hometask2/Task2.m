clear; clc; close all;

amp = 3;
freq = 1000;
fs = 2500;
dt = 1/fs;
t = 0:dt:3-dt;
signal = amp * sin(2*pi*freq*t);

N = fs * 3;
signal_spec = fft(signal,N);

signal_write = signal / (max(abs(signal)));     %had to normalise signal cause it is too wide
audiowrite('sinusoida.wav', signal_write, fs);

clipping_amp = 2;
singal_clipped = signal .* (signal <= clipping_amp & signal >= -clipping_amp) + clipping_amp .* (signal > clipping_amp) + (-clipping_amp) * (signal < -clipping_amp);

singal_clipped_spec = fft(singal_clipped);

axis = linspace(-fs/2, fs/2, N);

figure;
plot(t, signal, t, singal_clipped);
xlabel('time'); ylabel('amplitude'); title('signal, clipped signal from freq');

figure;
plot(axis/1000, fftshift(abs(signal_spec)), axis/1000, fftshift(abs(singal_clipped_spec)));
xlabel('frequency'); ylabel('amplitude'); title('signal spectrum, clipped signal spectrum from freq');

fprintf("As can be seen from the graphs, after the clipping effect the fundamental harmonic became slightly " + ...
        "less, but a few small ones appeared.")