clc; clear; close all;
%%nhiễu trắng
%% 0. Thiet lap thong so kịch ban SISO - Khong Fading (AWGN)
PdB = 0:3:30;             % Cong suat phat (dB)
P = 10.^(PdB/10);         % Cong suat phat tuyen tinh
Omega = 2;                % Do loi kenh truyen 
R = 1;                    % Toc do truyen mong muon (bps/Hz)
gth = 2^R - 1;            % Nguong dung
B = 1;                    % Bang thong chuan hoa
N_sim = 10^5;             % So luong phep thu 

gamma_avg = P .* Omega;   % Ty so tin hieu tren nhieu (SNR) co dinh

%% 3.1 & 3.2. Tinh toan Ly thuyet (AWGN)
% 3.1 Dung luong: Ap dung truc tiep cong thuc Shannon
CR_lythuyet = B .* log2(1 + gamma_avg);

% 3.2 Xac suat dung: Ham bac thang (1 neu SNR < nguong, 0 neu SNR >= nguong)
OP_lythuyet = double(gamma_avg < gth); 

%% 3.3 & 3.4. Mo phong (Monte Carlo)
CR_mophong = zeros(1, length(PdB));
OP_mophong = zeros(1, length(PdB));

for idx = 1:length(PdB)
    % Kenh truyen KHONG co fading -> h la mot hang so bang sqrt(Omega)
    h = sqrt(Omega) * ones(1, N_sim);
    
    % SNR tuc thoi (se khong co su dao dong, giong het tung diem gamma_avg)
    gamma_inst = P(idx) .* abs(h).^2;
    
    % 3.3. Dung luong Mo phong
    CR_mophong(idx) = sum(B .* log2(1 + gamma_inst)) / N_sim;
    
    % 3.4. Xac suat dung Mo phong
    OP_mophong(idx) = sum(gamma_inst < gth) / N_sim;
end

%% 3.5. Kiem tra va danh gia tren do thi
figure;

% --- Do thi so sanh Dung luong ---
subplot(1,2,1);
plot(PdB, CR_lythuyet, 'b-', 'LineWidth', 1.5); hold on;
plot(PdB, CR_mophong, 'ro', 'MarkerSize', 6);
grid on;
xlabel('Ty so tin hieu tren nhieu (dB)');
ylabel('Dung luong kenh truyen (bps/Hz)'); 
legend('Ly thuyet AWGN', 'Mo phong AWGN', 'Location', 'Best');
title('Danh gia Dung luong (Khong Fading)');

% --- Do thi so sanh Xac suat dung ---
subplot(1,2,2);
% Dung plot thay vi semilogy vi OP co the bang 0 tuyet doi (log(0) se bao loi)
plot(PdB, OP_lythuyet, 'b-', 'LineWidth', 1.5); hold on;
plot(PdB, OP_mophong, 'ro', 'MarkerSize', 6);
grid on;
xlabel('Ty so tin hieu tren nhieu (dB)');
ylabel('Xac suat dung');
legend('Ly thuyet AWGN', 'Mo phong AWGN', 'Location', 'Best');
title('Danh gia Xac suat dung (Khong Fading)');
ylim([-0.1 1.1]); % Chinh truc Y de de nhin hinh bac thang

set(gcf, 'color', 'w');