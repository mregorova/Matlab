function [Dictionary, Bit_depth_Dict] = dict_function(Constellation)

[Dictionary, Bit_depth_Dict] = constellation_func(Constellation);
points = linspace(0, 2^Bit_depth_Dict - 1, 2^Bit_depth_Dict);
Bit_depth_Dict = dec2bin(points);

if Constellation == "BPSK"
    Dictionary = Dictionary + 1e-20i;
end