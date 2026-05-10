clear all; close all; clc;
N = 100;               % Length of data
n = 0:1:19;            % Time samples
a = cos(2*pi*n*5/N);
figure(); subplot(2,1,1);
stem(n, a);
xlabel('Time Index');
ylabel('Amplitude');
title('Original Discrete Signal');
b = fft(a); subplot(2,1,2);
stem(n, abs(b));
xlim([min(n) max(n)+1]);
xlabel('Frequency Index');
ylabel('Magnitude');
title('Magnitude of FFT (Default Length)');
c=fft(a,200);figure();stem(abs(c));
xlabel('Frequency Index');
ylabel('Magnitude');
title('Magnitde of FFT (Larger Length)');