clc; clear; close all;

rng(1);
N = 1e5;                    % Số bit (chọn số chia hết cho 4 để 16-QAM ko lỗi)
N = N - mod(N,4);           % Đảm bảo chia hết cho 4
SNR_dB = -4:2:14;           % Dải Eb/N0 (16-QAM cần SNR cao hơn để thấy lỗi giảm)
SNR_lin = 10.^(SNR_dB/10);

BER_bpsk = zeros(size(SNR_dB));
BER_qpsk = zeros(size(SNR_dB));
BER_16qam = zeros(size(SNR_dB));

%% ================= BPSK (1 bit/sym) =================
bits = randi([0 1], N, 1);
bpsk = 2*bits - 1; 

for k = 1:length(SNR_dB)
    noise = sqrt(1/(2*SNR_lin(k))) * randn(N,1); % Es = Eb
    rx = bpsk + noise;
    BER_bpsk(k) = mean(bits ~= (rx > 0));
end

%% ================= QPSK (2 bit/sym) =================
% Mapping: 0->-1, 1->1
bits2 = reshape(bits, 2, []).';
qpsk = (2*bits2(:,1)-1) + 1j*(2*bits2(:,2)-1);
qpsk = qpsk / sqrt(2);      % Chuẩn hóa Es=1

for k = 1:length(SNR_dB)
    % Es = 2*Eb => Noise scale chia cho 2*2*SNR = 4*SNR
    scale = sqrt(1/(4*SNR_lin(k))); 
    noise = scale * (randn(size(qpsk)) + 1j*randn(size(qpsk)));
    
    rx = qpsk + noise;
    
    % Demod
    bits_hat = zeros(size(bits2));
    bits_hat(:,1) = real(rx) > 0;
    bits_hat(:,2) = imag(rx) > 0;
    
    BER_qpsk(k) = mean(bits ~= reshape(bits_hat.', [], 1));
end

%% ================= 16-QAM (4 bit/sym) =================
% Mapping Gray: 00->-3, 01->-1, 11->+1, 10->+3
% Ta tách 4 bit thành: 2 bit cho phần Thực (I), 2 bit cho phần Ảo (Q)
bits4 = reshape(bits, 4, []).';
bit_I = bits4(:, 1:2); % 2 bit đầu
bit_Q = bits4(:, 3:4); % 2 bit sau

% Hàm map 2 bit sang PAM-4 (Gray: 00=-3, 01=-1, 11=1, 10=3)
% Cách nhanh: map dec [0 1 3 2] sang [-3 -1 1 3]
map_gray = [-3 -1 3 1]; 
idx_I = 2*bit_I(:,1) + bit_I(:,2); % Đổi 2 bit sang thập phân (0,1,2,3)
idx_Q = 2*bit_Q(:,1) + bit_Q(:,2);

sym_I = map_gray(idx_I + 1).'; % Map sang biên độ
sym_Q = map_gray(idx_Q + 1).';

qam16 = sym_I + 1j*sym_Q;
qam16 = qam16 / sqrt(10); % Chuẩn hóa: (Avg Power = (1^2+3^2)/2 * 2 = 10) -> chia sqrt(10)

for k = 1:length(SNR_dB)
    % Es = 4*Eb => Noise scale chia cho 2*4*SNR = 8*SNR
    scale = sqrt(1/(8*SNR_lin(k))); 
    noise = scale * (randn(size(qam16)) + 1j*randn(size(qam16)));
    
    rx = qam16 + noise;
    
    % Demod (Ngược lại quá trình map)
    rx_I = real(rx) * sqrt(10); % Nhân lại để về mức -3, -1, 1, 3
    rx_Q = imag(rx) * sqrt(10);
    
    % Decision thresholds cho PAM-4: -2, 0, 2
    dec_I = zeros(size(rx_I,1), 2);
    dec_Q = zeros(size(rx_Q,1), 2);
    
    % Xử lý phần thực (I)
    dec_I(rx_I < -2, :) = repmat([0 0], sum(rx_I < -2), 1);         % < -2 -> -3 (00)
    dec_I(rx_I >= -2 & rx_I < 0, :) = repmat([0 1], sum(rx_I >= -2 & rx_I < 0), 1); % -1 (01)
    dec_I(rx_I >= 0 & rx_I < 2, :) = repmat([1 1], sum(rx_I >= 0 & rx_I < 2), 1);   % +1 (11)
    dec_I(rx_I >= 2, :) = repmat([1 0], sum(rx_I >= 2), 1);         % > +2 -> +3 (10)
    
    % Xử lý phần ảo (Q) - tương tự
    dec_Q(rx_Q < -2, :) = repmat([0 0], sum(rx_Q < -2), 1);
    dec_Q(rx_Q >= -2 & rx_Q < 0, :) = repmat([0 1], sum(rx_Q >= -2 & rx_Q < 0), 1);
    dec_Q(rx_Q >= 0 & rx_Q < 2, :) = repmat([1 1], sum(rx_Q >= 0 & rx_Q < 2), 1);
    dec_Q(rx_Q >= 2, :) = repmat([1 0], sum(rx_Q >= 2), 1);
    
    bits_hat_16 = [dec_I dec_Q]; % Ghép lại thành 4 cột
    BER_16qam(k) = mean(bits ~= reshape(bits_hat_16.', [], 1));
end

%% ================= LÝ THUYẾT =================
ber_bpsk_th = qfunc(sqrt(2*SNR_lin));
% Lý thuyết 16-QAM xấp xỉ: (3/4)*Q(sqrt(4/5 * EbNo))
ber_16qam_th = (3/4)*qfunc(sqrt((4/5)*SNR_lin)); 

%% ================= VẼ HÌNH =================
figure;
semilogy(SNR_dB, ber_bpsk_th, 'k-', 'LineWidth', 2); hold on;
semilogy(SNR_dB, ber_16qam_th, 'k--', 'LineWidth', 2);
semilogy(SNR_dB, BER_bpsk, 'bo', 'LineWidth', 1.5);
semilogy(SNR_dB, BER_qpsk, 'rs', 'LineWidth', 1.5);
semilogy(SNR_dB, BER_16qam, 'g^', 'LineWidth', 1.5, 'MarkerSize', 8);

grid on;
xlabel('Eb/N0 (dB)');
ylabel('BER');
title('So sánh BER: BPSK, QPSK và 16-QAM');
legend('Lý thuyết BPSK/QPSK', 'Lý thuyết 16-QAM', 'BPSK Sim', 'QPSK Sim', '16-QAM Sim');
ylim([1e-5 1]);