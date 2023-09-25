% Clear workspace. Clear command window. Close all figure
clear all; clc; close all;
%% task
% 0) Create a function
% 1) Create the random matrix
% 2) Analyse the code. Insert the calculation of runtime of code
% 3) rewrite the code in more optimised form in matlab
% 4) Provide the evidence that results matrix and legacy matrix is the same
% 5) calculate the runtime of new code. Compare it with legacy code. Make
% an conclusion about code. Which one is the more optimised? Which code do
% you suggest to use in matlab? And why?
%% Config the system

% Fixed random generator
rng(101);
% TO-DO 1%
% Create function, which generate 
% create Input_Matrix matrix 420-to-480 size and
% with normal distributed numbers from -200 to 20
%    

num_row = 420;
num_col = 480;

lower_bound = -200;
upper_bound = 20;

Input_Matrix = Matrix_generator(num_row, num_col, lower_bound, upper_bound);
  
Legacy_Matrix = Input_Matrix;
Ethalon_Matrix = Input_Matrix;

%% Run legacy code
% TO-DO 2
% Measure the runtime of current function

[Legacy_output_Matrix, Time_legacy_code] = Legacy_Instruction(Input_Matrix);

% Save the runtime in variable
% Time_legacy_code = TIME;

%% Run optimised code
% TO-DO 3
% Measure the runtime of your function
% Create function New_Instruction()
% Rewrite and optimised function Legacy_Instruction()
% Use matrix operation, logical indexing
% Try not to use the cycle

[Optimised_Output_Matrix, Time_Optimised_code] = New_Instruction(Input_Matrix);

% Save the runtime in variable
% Time_Optimised_code = TIME;
    
%% Checking the work of student
% TO-DO 4
% Compare the matrix and elapsed time for instruction
% Matrix must be equal each other, but the runtime sill be different

if (Optimised_Output_Matrix == Legacy_output_Matrix)
    fprintf("Matrices are equal\n");
    fprintf("Function Legacy_Instruction: %ld\n", Time_legacy_code);
    fprintf("Function New_Instruction: %ld\n", Time_Optimised_code);
else
    fprintf("Matrices are not equal!\n")
end

% Runtime comparison
%Function Legacy_Instruction: 3.196280e-02
%Function New_Instruction: 7.434700e-03


%As we see, New_Instruction code is more optimised than Legacy_Instruction.
%It is faster in 2 times, so it is better to use it for calculations.


%% Function discribing

function [Output_Matrix, Time_legacy_code] = Legacy_Instruction(Matrix)
   
    tic

    for itter_rows = 1 : size(Matrix,1)
        for itter_column = 1 : size(Matrix,2)
            if mod(itter_rows,8) == 0
                Matrix(itter_rows,itter_column) = 8;
            end
        end
    end

   for itter_rows = 1 : size(Matrix,1)
        for itter_column = 1 : size(Matrix,2)
            if mod(itter_column,7) ~= 0
                Matrix(itter_rows,itter_column) = Matrix(itter_rows,itter_column) - 25.8;
            end
        end
   end

   for itter_rows = 1 : size(Matrix,1)
        for itter_column = 1 : size(Matrix,2)
            if Matrix(itter_rows,itter_column) < 0
                Matrix(itter_rows,itter_column) = abs(Matrix(itter_rows,itter_column));
            end
        end
   end

   Time_legacy_code = toc;

   Output_Matrix = Matrix;
end


