function [output_matrix] = Matrix_generator(num_row, num_col, lower_bound, upper_bound)

    output_matrix = lower_bound + (upper_bound - lower_bound) * rand([num_row, num_col]);

end