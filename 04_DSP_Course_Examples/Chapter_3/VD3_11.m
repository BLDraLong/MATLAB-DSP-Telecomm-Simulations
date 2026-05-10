clear all; close all; clc;
N = 100;                                % Length of data
N1 = 100/5; 
T = [2 10 5.5]; 
Np = [2*N1 10*N1 5.5*N1]; 
Fs = 1; % Sampling frequency (assumed to be 1)

figure; % Create a single figure for all subplots

for i = 1:3
    n = 0:1:Np(i)-1;
    a = cos(2*pi*n*5/N); 
    
    subplot(2, 3, i); % Create subplots in a 2x3 grid
    stem(n, a, 'blue', 'LineWidth', 1, 'MarkerFaceColor', 'b'); 
    xlabel('Time Index');
    ylabel('Amplitude');
    title(['Discrete Signal, Number of Cyclic=', num2str(T(i))]);

    b = fft(a);
    f = (0:length(b)-1)*Fs/length(b); % Calculate frequency axis
    
    % Điều chỉnh giới hạn trục tần số và biên độ
    subplot(2, 3, i+3); 
    stem(f, abs(b), 'r', 'LineWidth', 1, 'MarkerFaceColor', 'r'); 
    xlim([0 40]); % Giới hạn trục tần số từ 0 đến 40
    ylim([0 20]); % Giới hạn trục biên độ từ 0 đến 20
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    title(['Magnitude of FFT, Number of Cyclic=', num2str(T(i))]);
end