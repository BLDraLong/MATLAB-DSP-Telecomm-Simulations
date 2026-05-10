% =========================================================================
% THÍ NGHIỆM 2.2.1: TÌM THÔNG SỐ HỆ HỞ (K, T1, T2) BẰNG PHƯƠNG PHÁP TIẾP TUYẾN
% =========================================================================
clc; clear; close all;

%% 1. KHAI BÁO HỆ THỐNG LÒ NHIỆT (HỆ HỞ)
s = tf('s');
G1 = 1 / (364*s + 1);
G2 = 100 / (1495*s + 1);
Gp = G1 * G2; % Hàm truyền hệ hở

% Khai báo tín hiệu đầu vào (Hàm nấc biên độ 100 theo đề bài)
U = 100; 

%% 2. MÔ PHỎNG ĐÁP ỨNG VÀ TÌM ĐIỂM UỐN
% Lấy dữ liệu đáp ứng hệ hở trong 10000 giây (do lò nhiệt tăng chậm)
[y, t] = step(U * Gp, 10000);

% Tìm đạo hàm (độ dốc) của đường cong đáp ứng
dy = diff(y) ./ diff(t);

% Tìm điểm uốn (Nơi có độ dốc lớn nhất)
[max_slope, max_idx] = max(dy);
t_uon = t(max_idx);
y_uon = y(max_idx);

%% 3. TÍNH TOÁN K, T1, T2 THEO TIẾP TUYẾN
% Độ lợi tĩnh K = Delta Y / Delta U
Y_max = y(end); % Giá trị xác lập
K = Y_max / U;

% Phương trình tiếp tuyến: y_tgt = max_slope * (t - t_uon) + y_uon
% Tìm T1: Giao điểm của tiếp tuyến với trục hoành (y = 0)
% 0 = max_slope * (T1 - t_uon) + y_uon => T1 = t_uon - y_uon / max_slope
T1 = t_uon - (y_uon / max_slope);

% Tìm T2: Khoảng thời gian từ T1 đến khi tiếp tuyến cắt đường xác lập Y_max
% Y_max = max_slope * (T_giao - t_uon) + y_uon
T_giao = t_uon + ((Y_max - y_uon) / max_slope);
T2 = T_giao - T1;

%% 4. IN KẾT QUẢ RA MÀN HÌNH
fprintf('--- KẾT QUẢ TÌM THÔNG SỐ (THÍ NGHIỆM 2.2.1) ---\n');
fprintf('Hệ số khuếch đại (K)  = %.4f\n', K);
fprintf('Thời gian trễ    (T1) = %.4f (s)\n', T1);
fprintf('Hằng số thời gian(T2) = %.4f (s)\n\n', T2);

%% 5. VẼ ĐỒ THỊ MINH HỌA CHO BÁO CÁO
figure;
plot(t, y, 'b', 'LineWidth', 2); hold on;

% Vẽ đường xác lập Y_max
yline(Y_max, 'k--', 'LineWidth', 1.5, 'Label', 'Y_{max}');

% Vẽ đường tiếp tuyến (kéo dài từ t=0 đến điểm cắt T_giao + 1000)
t_tgt = linspace(0, T_giao + 1000, 100);
y_tgt = max_slope * (t_tgt - t_uon) + y_uon;
plot(t_tgt, y_tgt, 'r-', 'LineWidth', 1.5);

% Đánh dấu các điểm T1 và T1+T2
plot(T1, 0, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
plot(T_giao, Y_max, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
plot(t_uon, y_uon, 'go', 'MarkerSize', 8, 'MarkerFaceColor', 'g');

% Chú thích đồ thị
ylim([0 Y_max*1.1]);
xlim([0 6000]);
grid on;
title('Xác định thông số K, T1, T2 bằng phương pháp tiếp tuyến');
xlabel('Thời gian (s)');
ylabel('Nhiệt độ');
legend('Đáp ứng hệ hở', 'Tiếp tuyến điểm uốn', 'Location', 'southeast');

% Ghi chú chữ T1, T2 lên đồ thị
text(T1, -Y_max*0.05, 'T_1', 'Color', 'r', 'FontSize', 12, 'FontWeight', 'bold');
text(T_giao, Y_max*1.05, 'T_1 + T_2', 'Color', 'r', 'FontSize', 12, 'FontWeight', 'bold');