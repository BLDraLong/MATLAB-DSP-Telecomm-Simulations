%% 1. Khai báo hệ thống
s = tf('s');
G = 100 / ((364*s + 1) * (1495*s + 1));

%% 2. Lấy dữ liệu đáp ứng bước (Step Response)
[y, t] = step(G, 10000); % Mô phỏng trong 10000 giây
dt = t(2) - t(1);

%% 3. Tìm điểm uốn (Inflection Point)
% Điểm uốn là nơi đạo hàm bậc 1 đạt cực đại (độ dốc lớn nhất)
dy = diff(y) ./ diff(t); % Đạo hàm bậc 1
[max_slope, idx] = max(dy); % Độ dốc lớn nhất (m)

t_inf = t(idx); % Thời gian tại điểm uốn
y_inf = y(idx); % Giá trị đầu ra tại điểm uốn

%% 4. Tính toán K, T1, T2 theo phương pháp tiếp tuyến
% K: Hệ số khuếch đại (Giá trị xác lập cuối cùng)
K = y(end); 

% Phương trình tiếp tuyến tại điểm uốn: y = m*t + b
% => y - y_inf = max_slope * (t - t_inf)
% => y = max_slope * t + (y_inf - max_slope * t_inf)

% T1 (Thời gian trễ): Giao điểm của tiếp tuyến với trục hoành (y = 0)
% 0 = max_slope * T1 + (y_inf - max_slope * t_inf)
T1 = t_inf - (y_inf / max_slope);

% T2 (Hằng số thời gian): Khoảng thời gian từ T1 đến khi tiếp tuyến đạt giá trị K
% K = max_slope * (T1 + T2) + (y_inf - max_slope * t_inf)
% Rút gọn ta được:
T2 = K / max_slope;

%% 5. Hiển thị kết quả
fprintf('--- Kết quả xác định tham số ---\n');
fprintf('Hệ số khuếch đại K = %.2f\n', K);
fprintf('Thời gian trễ T1   = %.2f (s)\n', T1);
fprintf('Hằng số thời gian T2 = %.2f (s)\n', T2);

%% 6. Vẽ đồ thị kiểm tra
figure;
plot(t, y, 'b', 'LineWidth', 2); hold on;
% Vẽ tiếp tuyến
t_tangent = T1 : T1+T2+1000;
y_tangent = max_slope * (t_tangent - T1);
plot(t_tangent, y_tangent, 'r--', 'LineWidth', 1.5);
% Vẽ các đường dóng
line([T1 T1], [0 K], 'Color', 'g', 'LineStyle', ':');
line([T1+T2 T1+T2], [0 K], 'Color', 'g', 'LineStyle', ':');
line([0 T1+T2], [K K], 'Color', 'k', 'LineStyle', '--');
title('Xác định K, T1, T2 bằng phương pháp tiếp tuyến');
legend('Đáp ứng hệ thống', 'Đường tiếp tuyến');
grid on;