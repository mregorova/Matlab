function [] = dict_const(IQ_TX, Constellation)

[Dictionary, Bit_depth_Dict] = constellation_func(Constellation);

for itter = 1 : length(IQ_TX)
    switch Constellation
        case "BPSK"
            switch IQ_TX(itter)
                case Dictionary(1)
                    text(real(Dictionary(1)), imag(Dictionary(1)), '0')
                case Dictionary(2)
                    text(real(Dictionary(2)), imag(Dictionary(2)), '1')
            end

        case "QPSK"
            switch IQ_TX(itter)
                case Dictionary(1)
                    text(real(Dictionary(1)), imag(Dictionary(1)),  '00')
                case Dictionary(2)
                    text(real(Dictionary(2)), imag(Dictionary(2)),  '01')
                case Dictionary(3)
                    text(real(Dictionary(3)), imag(Dictionary(3)),  '10')
                case Dictionary(4)
                    text(real(Dictionary(4)), imag(Dictionary(4)),  '11')
            end

        case "8PSK"
            switch IQ_TX(itter)
                case Dictionary(1)
                    text(real(Dictionary(1)), imag(Dictionary(1)),  '000')
                case Dictionary(2)
                    text(real(Dictionary(2)), imag(Dictionary(2)),  '001')
                case Dictionary(3)
                    text(real(Dictionary(3)), imag(Dictionary(3)),  '010')
                case Dictionary(4)
                    text(real(Dictionary(4)), imag(Dictionary(4)),  '011')
                case Dictionary(5)
                    text(real(Dictionary(5)), imag(Dictionary(5)),  '100')
                case Dictionary(6)
                    text(real(Dictionary(6)), imag(Dictionary(6)),  '101')
                case Dictionary(7)
                    text(real(Dictionary(7)), imag(Dictionary(7)),  '110')
                case Dictionary(8)
                    text(real(Dictionary(8)), imag(Dictionary(8)),  '111')
            end

        case "16-QAM"
            switch IQ_TX(itter)
                case Dictionary(1)
                    text(real(Dictionary(1)), imag(Dictionary(1)),  '1110')
                case Dictionary(2)
                    text(real(Dictionary(2)), imag(Dictionary(2)),  '1010')
                case Dictionary(3)
                    text(real(Dictionary(3)), imag(Dictionary(3)),  '1111')
                case Dictionary(4)
                    text(real(Dictionary(4)), imag(Dictionary(4)),  '1011')
                case Dictionary(5)
                    text(real(Dictionary(5)), imag(Dictionary(5)),  '0010')
                case Dictionary(6)
                    text(real(Dictionary(6)), imag(Dictionary(6)),  '0110')
                case Dictionary(7)
                    text(real(Dictionary(7)), imag(Dictionary(7)),  '0011')
                case Dictionary(8)
                    text(real(Dictionary(8)), imag(Dictionary(8)),  '0111')
                case Dictionary(9)
                    text(real(Dictionary(9)), imag(Dictionary(9)),  '1100')
                case Dictionary(10)
                    text(real(Dictionary(10)), imag(Dictionary(10)),  '1000')
                case Dictionary(11)
                    text(real(Dictionary(11)), imag(Dictionary(11)),  '1101')
                case Dictionary(12)
                    text(real(Dictionary(12)), imag(Dictionary(12)),  '1001')
                case Dictionary(13)
                    text(real(Dictionary(13)), imag(Dictionary(13)),  '0100')
                case Dictionary(14)
                    text(real(Dictionary(14)), imag(Dictionary(14)),  '0000')
                case Dictionary(15)
                    text(real(Dictionary(15)), imag(Dictionary(15)),  '0101')
                case Dictionary(16)
                    text(real(Dictionary(16)), imag(Dictionary(16)),  '0001')
            end
    end
end

end

