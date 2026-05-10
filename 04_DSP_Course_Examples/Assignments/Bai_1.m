
clc; clear; close all;

rng(1);
N = 1e5;
SNR_dB = -10:2:30;

bits = randi([0 1], N, 1);
bpsk = 2*bits - 1;

Ps = mean(abs(bpsk).^2);     % Công suất tín hiệu ~1
SNR_est = zeros(size(SNR_dB));

for k = 1:length(SNR_dB)

    snr_linear = 10^(SNR_dB(k)/10);
    Pn = Ps/snr_linear;     % công suất nhiễu
 
    % Nhiễu AWGN
    noise = sqrt(Pn) * randn(N,1);

    % Tín hiệu thu
    rx = bpsk + noise;

    % Ước lượng SNR
    Ps_hat = mean(abs(bpsk).^2);
    Pn_hat = mean(abs(noise).^2);
    SNR_est(k) = 10*log10(Ps_hat/Pn_hat);

end

figure;
plot(SNR_dB, SNR_est, 'o-', 'LineWidth', 2);
grid on;
xlabel('SNR đặt vào (dB)');
ylabel('SNR ước lượng (dB)');
title('Mô phỏng SNR trong kênh AWGN lý tưởng');
