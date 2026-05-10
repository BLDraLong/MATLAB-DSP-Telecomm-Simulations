clc; close all; clear;

% Simple Path Loss Model
d = 1:1000; d0 = 1; PL_d0 = 30; n = 3;
PL = PL_d0 + 10*n*log10(d/d0);
Pt_dB = 0; Pr_dB = Pt_dB - PL; Pr = 10.^(Pr_dB/10);

N = length(d); SNRdB = 10;

%% Rayleigh fading
h_rayleigh = sqrt(0.5)*(randn(N,1)+1j*randn(N,1));
Rx_rayleigh_noAWGN = Pr(:).*h_rayleigh;
Rx_rayleigh = awgn(Rx_rayleigh_noAWGN,SNRdB,'measured');

%% Rician fading
K = 5; Omega = 1;
v = sqrt(Omega*K/(K+1)); 
s = sqrt(Omega/(2*(K+1)));
X = v + s*randn(N,1); Y = s*randn(N,1);
h_rician = X + 1j*Y;
Rx_rician_noAWGN = Pr(:).*h_rician;
Rx_rician = awgn(Rx_rician_noAWGN,SNRdB,'measured');

%% Nakagami-m fading
m = 2; omega = 1;
r2 = gamrnd(m,omega/m,[N,1]); phi = 2*pi*rand(N,1);
h_nakagami = sqrt(r2).*exp(1j*phi);
Rx_nakagami_noAWGN = Pr(:).*h_nakagami;
Rx_nakagami = awgn(Rx_nakagami_noAWGN,SNRdB,'measured');

%% Vẽ bằng subplot
figure;

subplot(2,2,1);
plot(d,Pr_dB,'k--','LineWidth',2);
xlabel('Khoảng cách (m)'); ylabel('Công suất thu (dB)');
title('Path Loss lý thuyết'); grid on;

subplot(2,2,2);
plot(d,10*log10(abs(Rx_rayleigh_noAWGN)),'b-','LineWidth',1.5); hold on;
plot(d,10*log10(abs(Rx_rayleigh)),'r-','LineWidth',1.5); hold off;
xlabel('Khoảng cách (m)'); ylabel('Công suất thu (dB)');
title('Rayleigh fading'); legend('Không AWGN','Có AWGN'); grid on;

subplot(2,2,3);
plot(d,10*log10(abs(Rx_rician_noAWGN)),'b-','LineWidth',1.5); hold on;
plot(d,10*log10(abs(Rx_rician)),'r-','LineWidth',1.5); hold off;
xlabel('Khoảng cách (m)'); ylabel('Công suất thu (dB)');
title('Rician fading'); legend('Không AWGN','Có AWGN'); grid on;

subplot(2,2,4);
plot(d,10*log10(abs(Rx_nakagami_noAWGN)),'b-','LineWidth',1.5); hold on;
plot(d,10*log10(abs(Rx_nakagami)),'r-','LineWidth',1.5); hold off;
xlabel('Khoảng cách (m)'); ylabel('Công suất thu (dB)');
title('Nakagami-m fading'); legend('Không AWGN','Có AWGN'); grid on;

set(gcf,'color','white');
