clc; close all; clear;

%% Simple Path Loss Model
fc_MHz = 900;                  
d_km = linspace(0.1, 5, 200);                           % khoảng cách từ 0.1 km đến 5 km
fspl_dB = @(fc,d) 32.45 + 20*log10(fc) + 20*log10(d);

PL_simplified = fspl_dB(fc_MHz, d_km);

% Thêm AWGN vào path loss
sigma_noise = 2; 
noise_dB = sigma_noise * randn(size(d_km));
PL_awgn = PL_simplified + noise_dB;

%% Fading + AWGN
N = length(d_km);

% Rayleigh fading
h_rayleigh = sqrt(0.5)*(randn(N,1)+1j*randn(N,1));
Rx_rayleigh_noAWGN = PL_simplified(:) + 10*log10(abs(h_rayleigh).^2);
Rx_rayleigh = PL_awgn(:) + 10*log10(abs(h_rayleigh).^2);

% Rician fading
K = 5; v = sqrt(K/(K+1)); s = sqrt(1/(2*(K+1)));
h_rician = v + s*(randn(N,1)+1j*randn(N,1));
Rx_rician_noAWGN = PL_simplified(:) + 10*log10(abs(h_rician).^2);
Rx_rician = PL_awgn(:) + 10*log10(abs(h_rician).^2);

% Nakagami-m fading
m = 2; r2 = gamrnd(m,1/m,[N,1]); phi = 2*pi*rand(N,1);
h_nakagami = sqrt(r2).*exp(1j*phi);
Rx_nakagami_noAWGN = PL_simplified(:) + 10*log10(abs(h_nakagami).^2);
Rx_nakagami = PL_awgn(:) + 10*log10(abs(h_nakagami).^2);

%% Vẽ bằng subplot
figure;

% Simple Path Loss + AWGN
subplot(2,2,1);
plot(d_km, PL_simplified,'b-','LineWidth',1.5); hold on;
plot(d_km, PL_awgn,'r--','LineWidth',1.5); hold off;
xlabel('Khoảng cách (km)'); ylabel('Path loss (dB)');
title('Simple Path Loss + AWGN');
legend('Path loss lý thuyết','Path loss + AWGN'); grid on;

% Rayleigh
subplot(2,2,2);
plot(d_km, Rx_rayleigh_noAWGN,'b-','LineWidth',1.5); hold on;
plot(d_km, Rx_rayleigh,'r--','LineWidth',1.5); hold off;
xlabel('Khoảng cách (km)'); ylabel('Path loss (dB)');
title('Rayleigh fading'); legend('Không AWGN','Có AWGN'); grid on;

% Rician
subplot(2,2,3);
plot(d_km, Rx_rician_noAWGN,'b-','LineWidth',1.5); hold on;
plot(d_km, Rx_rician,'r--','LineWidth',1.5); hold off;
xlabel('Khoảng cách (km)'); ylabel('Path loss (dB)');
title('Rician fading'); legend('Không AWGN','Có AWGN'); grid on;

% Nakagami
subplot(2,2,4);
plot(d_km, Rx_nakagami_noAWGN,'b-','LineWidth',1.5); hold on;
plot(d_km, Rx_nakagami,'r--','LineWidth',1.5); hold off;
xlabel('Khoảng cách (km)'); ylabel('Path loss (dB)');
title('Nakagami-m fading'); legend('Không AWGN','Có AWGN'); grid on;

set(gcf,'color','white');
