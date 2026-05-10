clc; close all; clear;
% Nakagami-m fading channel + AWGN + lọc
N = 1e5;
m = 2; omega = 1;

% Tạo mẫu Nakagami
nakagami_samples = sqrt(gamrnd(m, omega/m, N,1));

% Thêm nhiễu AWGN
SNRdB = 10; 
SNR = 10^(SNRdB/10);
noise_power = var(nakagami_samples)/SNR;
noise = sqrt(noise_power/2).*(randn(N,1)+1i*randn(N,1));
rx = nakagami_samples + noise;

% Thiết kế bộ lọc thông thấp FIR
fc = 0.1; % tần số cắt (chuẩn hóa)
b = fir1(64, fc); % bộ lọc FIR bậc 64
rx_filtered = filter(b,1,rx);

% Vẽ kết quả
figure;
subplot(3,1,1);
histogram(abs(nakagami_samples),'Normalization','pdf');
title('Nakagami-m gốc');

subplot(3,1,2);
histogram(abs(rx),'Normalization','pdf');
title('Nakagami-m + AWGN');

subplot(3,1,3);
histogram(abs(rx_filtered),'Normalization','pdf');
title('Sau khi lọc nhiễu');
