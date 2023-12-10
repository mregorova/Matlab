clear; clc; close all;
load('Matlab_L3_6.mat')

len = 128; %заданная длина М-последовательности
eps = 0.001;

g_poly1 = [1 1 0 0 1 1 1 1]; %полином первого генератора 
g_gen1  = [1 0 0 1 0 1 1 1]; %начальное состояние регистров первого генератора
g_poly2 = [1 0 0 0 0 1 1 1]; %полином второго генератора 
g_gen2  = [1 1 0 0 1 0 1 1]; %начальное состояние регистров второго генератора
m_poly  = [1 1 0 0 1 1 1 1]; %полином генератора М-последовательности
m_init  = [1 0 0 1 0 1 1 1]; %начальное состояние генератора М-последовательности

m_seq = MSeq(m_init, m_poly, len); %генерация М-последовательности
gold_seq_1 = MSeq(g_gen1, g_poly1, len);
gold_seq_2 = MSeq(g_gen2, g_poly2, len);
gold_seq = xor(gold_seq_1, gold_seq_2);

xcorr_gold = xcorr_another(gold_seq, Bit_Stream_1);
xcorr_m = xcorr_another(m_seq, Bit_Stream_2);

[Data_Length_1, Frame_Length_1, Start_Of_Frame_Position_1, Number_Of_Frames_1] = propers(xcorr_gold, length(gold_seq), length(Bit_Stream_1), 1, eps);
[Data_Length_2, Frame_Length_2, Start_Of_Frame_Position_2, Number_Of_Frames_2] = propers(xcorr_gold, length(gold_seq), length(Bit_Stream_2), 1, eps);

fprintf("Data_Length of Gold seq = %d\n", Data_Length_1(end));
fprintf("Frame_Length of Gold seq = %d\n", Frame_Length_1(end));
fprintf("Start_Of_Frame_Position of Gold seq = %d\n", Start_Of_Frame_Position_1(end));
fprintf("Number_Of_Frames of Gold seq = %d\n", Number_Of_Frames_1);
fprintf("\n");
fprintf("Data_Length of M-seq = %d\n", Data_Length_2(end));
fprintf("Frame_Length of M-seq = %d\n", Frame_Length_2(end));
fprintf("Start_Of_Frame_Position of M-seq = %d\n", Start_Of_Frame_Position_2(end));
fprintf("Number_Of_Frames of M-seq = %d\n", Number_Of_Frames_2);
fprintf("\n");

figure;
plot(xcorr_gold)
hold on;
title("Корреляция от номера бита для кода Голда")
xlabel("Cмещение");
ylabel("Корреляция");
grid on;

figure;
plot(xcorr_m)
title("Корреляция от номера бита для M-последовательности")
xlabel("Cмещение");
ylabel("Корреляция");
grid on;

savefig("Frame_Corr.fig");

figure;
subplot(2, 1, 1)
plot(1:1:len*10, autocor(gold_seq, len*10))
title("Автокорреляция последовательноти кода Голда от номера бита");
ylabel("Корреляция");
xlabel("Смещение");
grid on;

subplot(2, 1, 2)
plot(1:1:len*10, autocor(m_seq, len*10))
title("Автокорреляция М-последовательности от номера бита");
ylabel("Корреляция");
xlabel("Смещение");
grid on;

PN_period = 2^length(m_poly) - 1;
fprintf("Период PN-последовательности равен 2^n - 1 = %d, n - количество бит\n", PN_period);
