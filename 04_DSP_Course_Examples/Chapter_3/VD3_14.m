clear all; close all; clc;
N = 50;fc=100;Fs = 1000;n=0:N-1;            % Length of data
h=(2*fc/Fs)*sinc(2*fc*(n-(N-1)/2)/Fs);
a=[1,0];b= h;figure;
subplot(2,1,1);zplane(b,a);
title('Pole-Zero Plot of Filter');
subplot(2,1,2);
stem(abs(b), 'filled'); title('Pole Magnitudes');
[H,w]=freqz(b,a,1024,Fs);
figure;subplot(2,1,1);
plot (w,abs(H));title('Frequency Response');
xlabel('Frequecy (Hz)'); ylabel('Magnitude');
subplot(2,1,2);
plot (w,angle(H));title('Phase Response');
xlabel('Frequecy (Hz)'); ylabel('Phase');