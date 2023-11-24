function [Data_Length, Frame_Length, Start_Of_Frame_Position, Number_Of_Frames] = propers(Bit_Stream, seq, len)
    opt_len = floor(length(Bit_Stream) / 128) + 1;
    Data_Length = zeros(1, opt_len - 1);
    Frame_Length = 0;
    Start_Of_Frame_Position = zeros(1, opt_len);
    Number_Of_Frames = 1;    

    i = 1;
    while i <= length(Bit_Stream) - (len - 1)
        if sum(seq - Bit_Stream(i : i + len - 1)) == 0

           Start_Of_Frame_Position(Number_Of_Frames) = i;
           i = i + len - 1;

           if Number_Of_Frames > 1
            Data_Length(Number_Of_Frames - 1) = Start_Of_Frame_Position(Number_Of_Frames) - Start_Of_Frame_Position(Number_Of_Frames - 1) - (len - 1);
           end

           Number_Of_Frames = Number_Of_Frames + 1;
        end
        
        i = i + 1;
        Frame_Length = Data_Length + len;

    end
end