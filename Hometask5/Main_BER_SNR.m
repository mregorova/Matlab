close all; clear; clc;

%% Init parametrs of model
Length_Bit_vector = 1e5;
Constellation = "QPSK"; % QPSK, 8PSK, 16-QAM
SNR = 20; % dB

%% Bit generator
Bit_Tx = randi([0,1], 1, Length_Bit_vector);

%% Mapping
IQ_TX = mapping(Bit_Tx, Constellation);

[Dictionary, Bit_depth_Dict] = dict_function(Constellation);

%% Channel
% Write your own function Eb_N0_convert(), which convert SNR to Eb/N0
Eb_N0 = Eb_N0_convert(SNR, Constellation);

% Use your own function of generating of AWGN from previous tasks
IQ_RX = NoiseGenerator(IQ_TX, SNR);

figure;
plot(IQ_RX, '.');
text(real(Dictionary) + 0.2, imag(Dictionary) + 0.2, Bit_depth_Dict);

hold on;
plot(Dictionary, 'x');
xlabel('I');
ylabel('Q');

ax = gca;
axis equal;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';

title("Constellation diagram with noise");
grid on;

%% Demapping
Bit_Rx = demapping(IQ_RX, Constellation);

%% Error check
% Write your own function Error_check() for calculation of BER
BER = Error_check(Bit_Tx, Bit_Rx);

%% Additional task. Modulation error ration

MER_estimation = MER_function(IQ_RX, Constellation);

% Compare the SNR and MER_estimation from -50dB to +50dB for BPSK, QPSK,
% 8PSK and 16QAM constellation.
% Plot the function of error between SNR and MER for each constellation 
% Discribe the results. Make an conclusion about MER.
% You can use the cycle for collecting of data
% Save figure

SNR_bound = 50;
idx_range = SNR_bound*2 + 1;

Length_Bit_vector = 1e4 * 3;

Constellations = ["BPSK", "QPSK", "8PSK", "16-QAM"];
SNR_x = -SNR_bound : SNR_bound;

%% MER

MER_res = zeros(4, 1);
delta = zeros(4, 1);

Bit_Tx_i = randi([0,1], 1, Length_Bit_vector);

for itter_c = 1 : 4
    Constellation_i = Constellations(itter_c);
    IQ_TX_i = mapping(Bit_Tx_i, Constellation_i);

    for itter = 1 : idx_range
        IQ_RX_i = NoiseGenerator(IQ_TX_i, SNR_x(itter));
        Bit_Rx_i = demapping(IQ_RX_i, Constellation_i);
        MER_res(itter_c, itter) = MER_function(IQ_RX_i, Constellation_i);
        delta(itter_c, itter) = abs(MER_res(itter_c, itter) - SNR_x(itter));
    end
end

h(1) = figure;
plot(SNR_x, MER_res, '-');
legend('BPSK', 'QPSK', '8PSK', '16-QAM')
xlabel('SNR, dB');
ylabel('MER(SNR)');
savefig(h(1), 'MER.fig');

figure;
plot(SNR_x, delta, '-');
legend('BPSK', 'QPSK', '8PSK', '16-QAM')
xlabel('SNR, dB');
ylabel('MER true value - MER experiment(SNR)');


%% Experimental BER(SNR) and BER(Eb/N0)
% Collect enough data to plot BER(SNR) and BER(Eb/N0) for each
% constellation.
% Compare the constalation. Describe the results
% You can use the cycle for collecting of data
% Save figure

tic
Eb_N0_i = zeros(4, idx_range);
BER_y = zeros(4, idx_range);

Bit_Tx_i = randi([0,1], 1, Length_Bit_vector);

for itter_c = 1 : 4
    Constellation_i = Constellations(itter_c);
    Eb_N0_i(itter_c, :) = Eb_N0_convert(SNR_x, Constellation_i);
    IQ_TX_i = mapping(Bit_Tx_i, Constellation_i);

    for itter = 1 : idx_range        
        IQ_RX_i = NoiseGenerator(IQ_TX_i, SNR_x(itter));
        Bit_Rx_i = demapping(IQ_RX_i, Constellation_i);
        BER_y(itter_c, itter) = Error_check(Bit_Tx_i, Bit_Rx_i);
    end
end
toc

h(2) = figure;
semilogy(SNR_x, BER_y, 'o-');
legend('BPSK', 'QPSK', '8PSK', '16-QAM')
grid on;
title('experimental curves BER(SNR)')
axis([-10 20 1e-4 1e0]);
xlabel('SNR, dB');
ylabel('BER(SNR)');
savefig(h(2), 'BER_SNR.fig');

h(3) = figure;
semilogy(Eb_N0_i(1, :), (BER_y(1, :)), 'o-', ...
     Eb_N0_i(2, :), (BER_y(2, :)), 'o-', ...
     Eb_N0_i(3, :), (BER_y(3, :)), 'o-', ...
     Eb_N0_i(4, :), (BER_y(4, :)), 'o-');
legend('BPSK', 'QPSK', '8PSK', '16-QAM')
axis([-20 12 1e-4 1e0]);
grid on;
xlabel('Eb/N0, dB');
ylabel('BER');
title('experimental curves BER(EB/N0)')
savefig(h(3), 'BER_EBN0.fig');

%% Theoretical lines of BER(Eb/N0)
% Read about function erfc(x) or similar
% Configure the function and get the theoretical lines of BER(Eb/N0)
% Compare the experimental BER(Eb/N0) and theoretical for BPSK, QPSK, 
% 8PSK and 16QAM constellation
% Save figure

tic
SNR_th_dB = -SNR_bound:0.1:SNR_bound;

EbN0_th_dB = zeros(4, length(SNR_th_dB));
EbN0_th_dB(1, :) = Eb_N0_convert(SNR_th_dB, 'BPSK');
EbN0_th_dB(2, :) = Eb_N0_convert(SNR_th_dB, 'QPSK');
EbN0_th_dB(3, :) = Eb_N0_convert(SNR_th_dB, '8PSK');
EbN0_th_dB(4, :) = Eb_N0_convert(SNR_th_dB, '16-QAM');

EbN0_th = zeros(4, length(SNR_th_dB));
EbN0_th(1, :) = 10.^(0.1*EbN0_th_dB(1, :));
EbN0_th(2, :) = 10.^(0.1*EbN0_th_dB(2, :));
EbN0_th(3, :) = 10.^(0.1*EbN0_th_dB(3, :));
EbN0_th(4, :) = 10.^(0.1*EbN0_th_dB(4, :));

BER_th = zeros(4, length(SNR_th_dB));
BER_th(1, :) = 1/2.*erfc(sqrt(EbN0_th(1, :)));
BER_th(2, :) = 1/2.*erfc(sqrt(EbN0_th(2, :)));
BER_th(3, :) = 2/3.*erfc(sqrt(6*EbN0_th(3, :))*sin(pi/8));
BER_th(4, :) = erfc(sqrt(12*EbN0_th(4, :)/15));
toc

h(4) = figure;
semilogy(EbN0_th_dB(1, :), (BER_th(1, :)), ...
    EbN0_th_dB(2, :), (BER_th(2, :)), ...
    EbN0_th_dB(3, :), (BER_th(3, :)), ...
    EbN0_th_dB(4, :), (BER_th(4, :)))
axis([-25 12 -5 0])
grid on;
legend('BPSK', 'QPSK', '8PSK', '16-QAM');
ylabel('log10(BER)')
xlabel('E_b/N_0 (dB)')
title('theoretical curves')
savefig(h(4), 'BER_theory.fig');

%% Plots of each constellations

h(5) = figure;
subplot(2,2,1);
p1 = semilogy(EbN0_th_dB(1, :), (BER_th(1, :)), Eb_N0_i(1, :), BER_y(1, :), 'o-');
p1(1).LineWidth = 2;
axis([-25 12 -5 0])
grid on;
legend('theoretical', 'experimental');
ylabel('log10(BER)')
xlabel('E_b/N_0 (dB)')
title('BPSK')

subplot(2,2,2);
p2 = semilogy(EbN0_th_dB(2, :), (BER_th(2, :)), Eb_N0_i(2, :), BER_y(2, :), 'o-');
p2(1).LineWidth = 2;
axis([-25 12 -5 0])
grid on;
legend('theoretical', 'experimental');
ylabel('log10(BER)')
xlabel('E_b/N_0 (dB)')
title('QPSK')

subplot(2,2,3);
p3 = semilogy(EbN0_th_dB(3, :), (BER_th(3, :)), Eb_N0_i(3, :), BER_y(3, :), 'o-');
p3(1).LineWidth = 2;
axis([-25 12 -5 0])
grid on;
legend('theoretical', 'experimental');
ylabel('log10(BER)')
xlabel('E_b/N_0 (dB)')
title('8PSK')

subplot(2,2,4);
p4 = semilogy(EbN0_th_dB(4, :), (BER_th(4, :)), Eb_N0_i(4, :), BER_y(4, :), 'o-');
p4(1).LineWidth = 2;
axis([-25 12 -5 0])
grid on;
legend('theoretical', 'experimental');
ylabel('log10(BER)')
xlabel('E_b/N_0 (dB)')
title('16-QAM')

savefig(h(5), 'BER_theory_experiment_total.fig');
