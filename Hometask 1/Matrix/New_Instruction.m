function [Output_Matrix, Time_Optimised_code] = New_Instruction(Matrix)
    
    tic

    Matrix(8:8:end, 1:end) = 8;

    Matrix(:, mod(1:end, 7) ~= 0) = Matrix(:, mod(1:end, 7) ~= 0) - 25.8;

    boolean_matrix = (Matrix < 0);
    Matrix = Matrix - 2 .* Matrix .* boolean_matrix;

    Output_Matrix = Matrix;

    Time_Optimised_code = toc;

end