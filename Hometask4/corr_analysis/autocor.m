function autocor_res = autocor(signal, len)

    autocor_res(1 : len) = 0;
    
    for itter_cor = 1 : 1 : len
        shif_sz = itter_cor - round(len/2);
        autocor_res(itter_cor) = (sum(signal .* circshift(signal, shif_sz)))/len;
    end

end