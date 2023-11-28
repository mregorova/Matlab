function [Data_Length, Frame_Length, Start_Of_Frame_Position, Number_Of_Frames] = propers(xcorr, seq_len, stream_len, border_value, eps)

    Frame_Length = 0;
    Start_Of_Frame_Position = zeros(1, round(stream_len / (2 * seq_len)));
    Number_Of_Frames = 0;    

    for i = 1 :length(xcorr) - (seq_len - 1)
        if abs(xcorr(i) - border_value) < eps
            Number_Of_Frames = Number_Of_Frames + 1;
            Start_Of_Frame_Position(Number_Of_Frames) = i - seq_len - 1;
        end
    end
    Frame_Length = Start_Of_Frame_Position(2) - Start_Of_Frame_Position(1);
    Data_Length = seq_len - Frame_Length;
end
