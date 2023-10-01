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
    
%% Efficiency
Time_legacy_code_average = 0;
Time_Optimised_code_average = 0;
counter = 100;
Data_legacy = zeros(1, counter);
Data_Optimised = zeros(1, counter);

for i = 1 : counter
    rng(i);
    Input_Matrix = Matrix_generator(num_row, num_col, lower_bound, upper_bound);
    [Legacy_output_Matrix, Time_legacy_code_iter] = Legacy_Instruction(Input_Matrix);
    Data_legacy(i) = Time_legacy_code_iter;
    Time_legacy_code_average = Time_legacy_code_average + Time_legacy_code_iter;
    [Optimised_Output_Matrix, Time_Optimised_code_iter] = New_Instruction(Input_Matrix);
    Data_Optimised(i) =  Time_Optimised_code_iter;
    Time_Optimised_code_average = Time_Optimised_code_average + Time_Optimised_code_iter;
end

Dev_legacy = std(Data_legacy);
Dev_Optimised = std(Data_Optimised); %dev means deviation
Dev_average =  Dev_Optimised / Dev_legacy;

Time_legacy_code_average = Time_legacy_code_average / counter;
Time_Optimised_code_average = Time_Optimised_code_average / counter;

Efficiency = Time_legacy_code_average / Time_Optimised_code_average;

%% Plot of dispersion

x = linspace(0, 100);

plot(x, Data_legacy, 'r', 'LineWidth', 2);
hold on;
plot(x, Data_Optimised, 'b', 'LineWidth', 2);

xlabel('Number'); ylabel('Code execution time');
title('Dispersion of legacy execution time');
legend('legacy', 'optimised');
grid on;

hold off;

%% Checking the work of student
% TO-DO 4
% Compare the matrix and elapsed time for instruction
% Matrix must be equal each other, but the runtime sill be different

if (size(Optimised_Output_Matrix) == size(Legacy_output_Matrix))
    if (Optimised_Output_Matrix == Legacy_output_Matrix)
        fprintf("Matrices are equal\n");
        fprintf("Function Legacy_Instruction: %ld\n", Time_legacy_code);
        fprintf("Function New_Instruction: %ld\n", Time_Optimised_code);
        fprintf("General efficiency: %ld\n", Efficiency)
    else
        fprintf("Matrices are not equal!\n")
    end
else
    fprintf("Matrix size error!\n")
end

% Runtime comparison
% General efficiency is usually about 3

% We made sure that on every iteration time of execution is a random process
% It is caused by influence of machine's power on matlab calculations
% Let's calculate some parameters of this process and use them for conclusions
% Usuallly Time_legacy_code_average is +-228, Time_Optimised_code_average is +-228 
% To sum up, New_instruction is faster in General efficiency times

fprintf("\n");
fprintf("We made sure that on every iteration time of execution is a random process\n");
fprintf("It is caused by influence of machine's power on matlab calculations\n");
fprintf("Let's calculate some parameters of this process and use them for conclusions\n");
fprintf("Usually Time_legacy_code_average is %.2ld+-%.2ld, Time_Optimised_code_average is about %.2ld\n+-%.2ld", ...
    Time_legacy_code_average, Dev_legacy, Time_Optimised_code_average, Dev_Optimised);
fprintf("To sum up, New_instruction is faster in %.2ld+-%.2ld times\n", Efficiency, Dev_average);

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


