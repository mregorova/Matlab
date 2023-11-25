function [Bit] = demapping(IQ_RX, Constellation)
% Make the different dictionary for BPSK, QPSK, 8PSK, 16QAM constellations
% calculate the Bit_depth for each contellation

[Dictionary, Bit_depth_Dict] = constellation_func(Constellation);

% write  the function of mapping from IQ vector to bit vector

Bit = zeros(1, length(IQ_RX));

for itter1 = 1 : length(IQ_RX)
    t = IQ_RX(itter1) - Dictionary;
    [~, idx_min] = min(abs(t));
    Bit(itter1) = idx_min-1;
end

    Bit = int2bit(Bit, Bit_depth_Dict);
    Bit = reshape(Bit, [], 1);
    Bit = Bit';
end

