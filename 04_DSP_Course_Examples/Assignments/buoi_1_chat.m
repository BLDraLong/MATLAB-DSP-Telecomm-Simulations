clc; clear; close all;

rng(1);
N = 1e5;                    % Số bit

% LƯU Ý: Chỉ chạy đến 12 dB vì với N=1e5, BER về 0 sẽ không vẽ được
SNR_dB = -10:2:12;          
SNR_lin = 10.^(SNR_dB/10);  % Đây chính là Eb/N0 (tuyến tính)

BER_bpsk  = zeros(size(SNR_dB));
BER_qpsk  = zeros(size(SNR_dB));
BER_qam16 = zeros(size(SNR_dB));

%% ================= BPSK =================
bits = randi([0 1], N, 1);
bpsk = 2*bits - 1;          % BPSK: 1 bit = 1 symbol => Es = Eb

for k = 1:length(SNR_dB)
    % N0/2 = 1/(2*Eb/N0)
    noise = sqrt(1/(2*SNR_lin(k))) * randn(N,1);
    rx = bpsk + noise;
    bits_hat = rx > 0;
    BER_bpsk(k) = mean(bits ~= bits_hat);
end

%% ================= QPSK =================
bits = randi([0 1], N, 1);
if mod(N,2) ~= 0, bits = [bits; 0]; end
bits2 = reshape(bits, 2, []).';

qpsk = (2*bits2(:,1)-1) + 1j*(2*bits2(:,2)-1);
qpsk = qpsk / sqrt(2);      % Chuẩn hoá Es = 1

for k = 1:length(SNR_dB)
    % QPSK: Es = 2Eb → sigma^2 = 1/(4*Eb/N0)
    noise = sqrt(1/(4*SNR_lin(k))) * ...
        (randn(size(qpsk)) + 1j*randn(size(qpsk)));
    
    rx = qpsk + noise;

    bits_hat = zeros(size(bits2));
    bits_hat(:,1) = real(rx) > 0;
    bits_hat(:,2) = imag(rx) > 0;

    BER_qpsk(k) = mean(bits ~= bits_hat.');
end

%% ================= 16-QAM =================
bits = randi([0 1], N, 1);
if mod(N,4) ~= 0
    bits = [bits; zeros(4-mod(N,4),1)];
end
bits4 = reshape(bits, 4, []).';

% Gray mapping 16-QAM
I = (1-2*bits4(:,1)) .* (2 - (1-2*bits4(:,3)));
Q = (1-2*bits4(:,2)) .* (2 - (1-2*bits4(:,4)));

qam16 = I + 1j*Q;
qam16 = qam16 / sqrt(mean(abs(qam16).^2));  % Chuẩn hoá Es = 1

for k = 1:length(SNR_dB)
    % 16-QAM: Es = 4Eb → sigma^2 = 1/(8*Eb/N0)
    noise = sqrt(1/(8*SNR_lin(k))) * ...
        (randn(size(qam16)) + 1j*randn(size(qam16)));

    rx = qam16 + noise;

    bits_hat = zeros(size(bits4));
    bits_hat(:,1) = real(rx) < 0;
    bits_hat(:,2) = imag(rx) < 0;
    bits_hat(:,3) = abs(real(rx)) < 1/sqrt(10);
    bits_hat(:,4) = abs(imag(rx)) < 1/sqrt(10);

    BER_qam16(k) = mean(bits ~= bits_hat(:));
end

%% ================= BER LÝ THUYẾT =================
BER_theory_bpsk = qfunc(sqrt(2*SNR_lin));
BER_theory_qam16 = (3/8)*erfc(sqrt((4/10)*SNR_lin));

%% ================= VẼ BER =================
figure;
semilogy(SNR_dB, BER_theory_bpsk, 'k-', 'LineWidth',2); hold on;
semilogy(SNR_dB, BER_bpsk,  'bo', 'LineWidth',1.5);
semilogy(SNR_dB, BER_qpsk,  'r*', 'LineWidth',1.5);
semilogy(SNR_dB, BER_qam16, 'md', 'LineWidth',1.5);
semilogy(SNR_dB, BER_theory_qam16, 'm--', 'LineWidth',1.5);

grid on;
xlabel('Eb/N0 (dB)');
ylabel('BER');
title('So sánh BER BPSK, QPSK và 16-QAM (Chuẩn theo Eb/N0)');
legend('BPSK/QPSK Theory', 'BPSK Sim', 'QPSK Sim', ...
       '16-QAM Sim', '16-QAM Theory', 'Location','southwest');
ylim([1e-6 1]);
