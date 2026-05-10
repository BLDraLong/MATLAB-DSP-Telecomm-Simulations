clc; clear all; close all;

%% Thong so he thong kịch bản SISO - Rayleigh Fading
PdB = 0:3:30;             % Cong suat phat (dB)
P = 10.^(PdB/10);         % Cong suat phat tuyen tinh
Omega = 2;                % Do loi kenh truyen trung binh
R = 1;                    % Toc do truyen mong muon (bps/Hz)
gth = 2^R - 1;            % Nguong dung
B = 1;                    % Bang thong chuan hoa

%% 3.1 & 3.2 Tinh toan Ly thuyet
gamma_avg = P .* Omega;

% Dung luong ly thuyet (Rayleigh)
% Luu y: Ham expint trong MATLAB khac voi dinh nghia toan hoc tieu chuan
CR_a = -1/log(2) .* exp(1./gamma_avg) .* real(-expint(1./gamma_avg));

% Xac suat dung ly thuyet (Rayleigh)
OP_a = 1 - exp(-gth ./ gamma_avg);

%% 3.3 & 3.4 Mo phong Monte Carlo
N = 10^5; % So luong phep thu
CR_s = zeros(1, length(PdB));
OP_s = zeros(1, length(PdB));

for idx = 1:length(PdB)
    % Buoc 1: Tao kenh truyen Rayleigh bang bien gia ngau nhien phuc
    h = sqrt(Omega/2) .* (randn(1, N) + 1i*randn(1, N));
    
    % Buoc 2: Ty so tin hieu tren nhieu (SNR) tuc thoi
    gamma_inst = P(idx) .* abs(h).^2;
    
    % Buoc 3: Do dac ket qua
    % - Mo phong dung luong: lay trung binh Shannon capacity
    CR_s(idx) = sum(B .* log2(1 + gamma_inst)) / N;
    % - Mo phong OP: dem so lan dung luong < R (hay SNR < nguong gth)
    OP_s(idx) = sum(gamma_inst < gth) / N;
end

%% 3.5. Kiem tra va danh gia tren do thi
figure;

% --- Do thi Dung luong ---
subplot(1,2,1);
plot(PdB, CR_a, 'b-', 'LineWidth', 1.5); hold on;
plot(PdB, CR_s, 'ro');
grid on;
xlabel('Ty so tin hieu tren nhieu (dB)');
ylabel('Dung luong kenh truyen (bps/Hz)');
legend('Ly thuyet', 'Mo phong', 'Location', 'Best');
title('Dung luong kenh truyen (Capacity)');

% --- Do thi Xac suat dung ---
subplot(1,2,2);
semilogy(PdB, OP_a, 'b-', 'LineWidth', 1.5); hold on;
semilogy(PdB, OP_s, 'ro');
grid on;
xlabel('Ty so tin hieu tren nhieu (dB)');
ylabel('Xac suat dung');
legend('Ly thuyet', 'Mo phong', 'Location', 'Best');
title('Xac suat dung (Outage Probability)');

set(gcf, 'color', 'w');