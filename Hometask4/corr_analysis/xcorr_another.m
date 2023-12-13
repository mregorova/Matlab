function [xcorr_result] = xcorr_another(x1, x2, len)

    xcorr_result = zeros(1, len);
    array = [];
    
    if length(x1) < length(x2)
        x1 = [x1, xcorr_result(1 : (len - length(x1)))];
    end
    
    if length(x2) < length(x1)
        x2 = [x2, xcorr_result(1 : (len - length(x2)))];
    end
    
    for k = 1 : 1 : len
        array = circshift(x2, k - 1);
        for i = 1 : len
            xcorr_result(1, k) = (xcorr_result(1, k) + x1(i) * array(i)/64);
        end
    end
end

