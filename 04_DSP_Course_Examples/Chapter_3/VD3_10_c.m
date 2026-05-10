n = 0:1:99;            % Time samples
a = cos(2*pi*n*5/N);
subplot(1,1,1,'Position',[0.1,0.2,0.85,0.65]);
stem(n,a,'blue','LineWidth',1,'MarkerFaceColor','b');
xlabel('Time Index'); ylabel('Amplitude');
title('Original Discrete Signal');
b = fft(a);
subplot(1,1,1,'Position',[0.1,0.2,0.85,0.65]); 
stem(n,abs(b),'r','LineWidth',1,'MarkerFaceColor','r');
xlim([min(n) max(n)+1]);
xlabel('Frequency Index');
ylabel('Magnitude');
title('Magnitude of FFT (Default Length, N_F_F_T=20)');