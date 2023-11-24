function autocor_res = autocor(signal)

    autocor_res(1 : length(signal)) = 0;
    
    for itter_cor = 1 : length(signal)
        shif_sz = itter_cor - round(length(signal)/2);
        autocor_res(itter_cor) = (sum(signal .* circshift(signal, shif_sz)))/length(signal);
    end

end