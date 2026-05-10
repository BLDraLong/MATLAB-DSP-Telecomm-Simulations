clear all; close all; clc;
N = 100; 
fc = 100; 
Fs = 200; 
n = 0:N-1; 
h = (2*fc/Fs)*sinc(2*fc*(n-(N-1)/2)/Fs); 
a = [1, -1.5, 0.7]; 
b = h;
[H_num,H_den] = residuez(b,a); 
figure; 
zplane(b,a); 
subplot(2,1,1);zplane(H_num,H_den);
title('Pole-Zero Plot of Filter H(z)');


subplot(2,1,2);
zplane(H_num,H_den); 
title('Pole-Zero Plot of Filter H(z) after partial-fraction expansion');

[H_fir,w_fir] = freqz(b,1,1024,Fs); 
[H_combined,w_combined] = freqz(b,a,1024,Fs);

figure;
subplot(2,1,1);
plot(w_fir/pi*Fs/2,20*log10(abs(H_fir))); % Chuyển đổi tần số thành đơn vị Hz và tính dB
hold on;
plot(w_combined/pi*Fs/2,20*log10(abs(H_combined)),'r');
title('Frequency Response Comparison (Magnitude)');
xlabel('Frequency (Hz)'); 
ylabel('Magnitude (dB)');
legend('FIR Filter(h(z))','Combined Filter (H(z))');

subplot(2,1,2);
plot(w_fir/pi*Fs/2,angle(H_fir));
hold on;
plot(w_combined/pi*Fs/2,angle(H_combined),'r');
title('Frequency Response Comparison (Phase)');
xlabel('Frequency (Hz)'); 
ylabel('Phase (radians)');