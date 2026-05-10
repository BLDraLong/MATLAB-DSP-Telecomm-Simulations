    clear all; close all; clc;
    N = 400;                                % Length of data
    N1 = 100/5; 
    T = [2 10 5.5]; 
    Np = [2*N1 10*N1 5.5*N1]; 
    Fs = [4 8 2.001]; % Tần số lấy mẫu (giả sử là 40 Hz để trục tần số chạy đến 40 Hz)

    figure; % Create a single figure for all subplots

    for i = 1:length(Fs)
        t=(0:(N-1))/Fs(i);
        f= linspace(0,Fs(i),N);
        f0=1;f1=0.5;
        x0= sin(2*pi*f0*t)+0.55*sin(2*pi*f1*t);
        y=fft(x0);
        subplot(2, 3, i); % Create subplots in a 2x3 grid
        plot(f, abs(y), 'blue', 'LineWidth', 1, 'MarkerFaceColor', 'b'); 
        xlabel('Time Index');
        ylabel('Amplitude');
        title(['FFT with fs=',num2str(Fs(i))]);

    end