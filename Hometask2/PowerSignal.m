function P_Signal = PowerSignal(Signal)     %calculate average power of signal

S_real2 = Signal .* conj(Signal);
P_Signal = sum(S_real2) / length(Signal);

end

