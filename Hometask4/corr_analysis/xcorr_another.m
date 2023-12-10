function [xcorr_result] = xcorr_another(Seq, Bit_Stream)

    len_Seq = length(Seq);
    len_Bit_Stream = length(Bit_Stream);
    
    xcorr_result = zeros(1, len_Seq + len_Bit_Stream + 2);
    
    for i = 1 : len_Seq + len_Bit_Stream - 1
        beg_Seq  = len_Seq - i + 1;
        beg_Bit_Stream  = i - len_Seq + 1; 
        end_Seq = len_Bit_Stream + i - 1;
        end_Bit_Stream = i;

        if beg_Seq < 1
            beg_Seq = 1;
        end

        if end_Seq > len_Seq
            end_Seq = len_Seq;
        end

        if i > len_Bit_Stream
            end_Seq = len_Seq - (i - len_Bit_Stream);
            end_Bit_Stream = len_Bit_Stream;
        end

        if beg_Bit_Stream < 1
            beg_Bit_Stream = 1;
        end
        
        xcorr_result(i) = sum(Seq(beg_Seq : end_Seq) .* ...
        Bit_Stream(beg_Bit_Stream : end_Bit_Stream)) / (len_Seq + len_Bit_Stream + 2);

    end
end
