clear; clc; close all;

[signal, frec] = audioread('task3.wav');

N = length(signal);
n = 1:N;
signal_spec = fft(signal, N);

figure;
plot(n, abs(signal(:, 1)));
xlabel('n'); ylabel('A'); title('signal');

figure;
plot(n(1:N/2), abs(signal_spec(1:N/2, 1)));
xlabel('n'); ylabel('A'); title('signal spectrum');

N1 = round(N/2);
signal1 = zeros(N1, 2);
for itter = 1 : N1-1
    signal1(itter, :) = signal(itter * 2, :);
end

signal1_spec = fft(signal1, N1);

n1 = 1:N1;
figure;
plot(n1, signal1(:, 1));
xlabel('n'); ylabel('A'); title('signal after downsampling');

figure;
plot(n1(1:N1/2), abs(signal1_spec(1:N1/2, 1)));
xlabel('n'); ylabel('A'); title('signal spectrum after downsampling');

N2 = N * 2 - 1;
signal2 = zeros(N2, 2);

itter1 = 1;
for itter2 = 1 : N2
    if (mod(itter2, 2) == 1)
        signal2(itter2, :) = signal(itter1, :);
        itter1 = itter1 + 1;
    elseif(mod(itter2, 2) == 0 && itter2 ~= signal1(end))
        signal2(itter2, :) = (signal(itter1, :) + signal(itter1 - 1, :)) / 2;
    end
end

signal2_spec = fft(signal2, N2);

n2 = 1:N2;

figure;
plot(n2, signal2(:, 1));
xlabel('n'); ylabel('A'); title('signal after upsampling');

figure;
plot(n2(1:(N2+1)/2), abs(signal2_spec(1:(N2+1)/2, 1)));
xlabel('n'); ylabel('A'); title('signal spectrum after upsampling');

signal_spec = signal_spec/PowerSignal(signal_spec);
signal1_spec = signal1_spec/PowerSignal(signal1_spec);     %Normalize spectrums based on power
signal2_spec = signal2_spec/PowerSignal(signal2_spec);

figure;
p = plot(n(1:N/2), abs(signal_spec(1:N/2, 1)), ...
     n1(1:N1/2), abs(signal1_spec(1:N1/2, 1)), ...
     n2(1:(N2+1)/2), abs(signal2_spec(1:(N2+1)/2, 1)));

p(1).LineWidth = 4;
p(2).LineWidth = 3;
p(3).LineWidth = 1;

xlabel('k'); ylabel('A'); title('spectrum comparison');
legend('original spectrum', 'spectrum after downsampling', 'spectrum after upampling');