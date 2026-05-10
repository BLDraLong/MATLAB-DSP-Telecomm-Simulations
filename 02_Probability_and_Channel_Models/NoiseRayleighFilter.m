clc; close all; clear;
% Okumura-Hata Model (Urban)
f = 900; % MHz
hb = 50; % chiều cao anten trạm gốc (m)
hm = 1.5; % chiều cao anten di động (m)
d = 1:20; % khoảng cách (km)

a_hm = (1.1*log10(f)-0.7)*hm - (1.56*log10(f)-0.8);
PL_hata = 69.55 + 26.16*log10(f) - 13.82*log10(hb) ...
          - a_hm + (44.9 - 6.55*log10(hb))*log10(d);

% Công suất phát giả định (dBm)
Pt = 30; % 1 W
Pr = Pt - PL_hata; % công suất thu (dBm)

% Chuyển sang tuyến tính (W)
Pr_lin = 10.^(Pr/10)/1000;

% Thêm nhiễu AWGN với SNR = 10 dB
SNRdB = 10; SNR = 10^(SNRdB/10);
noise_power = mean(Pr_lin)/SNR;
noise = sqrt(noise_power/2).*(randn(size(Pr_lin))+1i*randn(size(Pr_lin)));
rx = sqrt(Pr_lin) + noise;

% Lọc thông thấp FIR
b = fir1(32,0.2); % bộ lọc FIR bậc 32
rx_filtered = filter(b,1,rx);

% Vẽ kết quả
figure;
subplot(3,1,1); plot(d,PL_hata); title('Suy hao Okumura-Hata'); ylabel('dB');
subplot(3,1,2); plot(d,abs(rx)); title('Tín hiệu thu + nhiễu');
subplot(3,1,3); plot(d,abs(rx_filtered)); title('Sau khi lọc nhiễu');
xlabel('Khoảng cách (km)');
