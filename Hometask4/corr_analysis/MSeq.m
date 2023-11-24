function M_Seq = MSeq(init, poly, seq_length)
    register = init;
    M_Seq = zeros(1, seq_length);

    for itter = 1 : seq_length
        new_register = xor(register(end), register(end - 1));
        M_Seq(itter) = new_register;

        bits = mod(sum(register .* poly), 2);
        register = [bits, register(1:end-1)];
    end
end