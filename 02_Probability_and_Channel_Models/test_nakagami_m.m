clc; clear; close all;

%% 0. Thiet lap thong so
PdB = 0:3:30;             % Cong suat phat (dB)
P = 10.^(PdB/10);         % Cong suat phat tuyen tinh
Omega = 2;                % Do loi kenh truyen trung binh
R = 1;                    % Toc do truyen mong muon (bps/Hz)
gth = 2^R - 1;            % Nguong dung
B = 1;                    % Bang thong chuan hoa
N_sim = 10^5;             % So luong phep thu cho Monte Carlo
m = 2;                    % Tham so fading Nakagami

gamma_avg = P .* Omega;   % Ty so tin hieu tren nhieu (SNR) trung binh

%% 3.1 & 3.2. Tinh toan Ly thuyet (Nakagami-m)
CR_lythuyet = zeros(1, length(PdB));
for idx = 1:length(PdB)
    g_avg = gamma_avg(idx);
    % Tich phan dung luong bang phuong phap so hoc
    pdf_nakagami = @(g) (m^m .* g.^(m-1)) ./ (g_avg^m * gamma(m)) .* exp(-m .* g ./ g_avg);
    cap_integrand = @(g) log2(1 + g) .* pdf_nakagami(g);
    CR_lythuyet(idx) = integral(cap_integrand, 0, Inf);
end

% Xac suat dung dung ham CDF cua phan bo Gamma
OP_lythuyet = gamcdf(gth, m, gamma_avg./m);

%% 3.3 & 3.4 Mo phong (Monte Carlo) GỌI FUNCTION CỦA BẠN
CR_mophong = zeros(1, length(PdB));
OP_mophong = zeros(1, length(PdB));

for idx = 1:length(PdB)
    % --- GỌI FUNCTION CÓ SẴN TẠI ĐÂY ---
    % Nhan them sqrt(Omega) de dat do loi kenh truyen mong muon
    % Chuyen vi phuc (.') de dam bao cung chieu vector hang voi P(idx)
    h = sqrt(Omega) .* (nakagami_fading(N_sim, m)).'; 
    
    % SNR tuc thoi
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
legend('Ly thuyet Nakagami', 'Mo phong Nakagami', 'Location', 'Best');
title(sprintf('Danh gia Dung luong (m = %g)', m));

% --- Do thi so sanh Xac suat dung ---
subplot(1,2,2);
semilogy(PdB, OP_lythuyet, 'b-', 'LineWidth', 1.5); hold on;
semilogy(PdB, OP_mophong, 'ro', 'MarkerSize', 6);
grid on;
xlabel('Ty so tin hieu tren nhieu (dB)');
ylabel('Xac suat dung');
legend('Ly thuyet Nakagami', 'Mo phong Nakagami', 'Location', 'Best');
title(sprintf('Danh gia Xac suat dung (m = %g)', m));

set(gcf, 'color', 'w');