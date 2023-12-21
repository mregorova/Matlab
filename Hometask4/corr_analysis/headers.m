function [Data_Length, Frame_Length, Start_Of_Frame_Position, Number_Of_Frames] = headers(xcorr, len)

xcorr_len = length(xcorr);
flags = zeros(1, xcorr_len);
i = 1;
j = 0;
k = 1;
header = 0;
start = 0;
finish = 0;


while i < xcorr_len
    %fprintf("%d\n", xcorr(it));
    if xcorr(i) > 0.9*1
        j = 0;
        start = i;

        while j <= (xcorr_len - i)
            if xcorr(i + j) < 0.9*1
                finish = i + j;
                j = xcorr_len + 100;
            else
                j = j + 1;
            end
        end

        i = finish;
        header = header + 1;
        flags(k) = fix((start + finish)/2);
        k = k + 1;
        i = i + 1;
    else 
        i = i + 1;
    end
end

Data_Length = flags(2) - flags(1) - len;
Frame_Length = Data_Length + len;
Start_Of_Frame_Position = fix(flags(1));
Number_Of_Frames = header;

end
