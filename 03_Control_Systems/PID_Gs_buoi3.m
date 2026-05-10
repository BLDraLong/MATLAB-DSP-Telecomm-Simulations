%% 1. Thông số động cơ và Hàm truyền vị trí Gp(s)
% Thông số STT 0 [cite: 35]
R = 0.62; L = 0.465; Kb = 0.0256; 
J = 0.031; B = 0.035; Kt = 0.078;

% Hàm truyền tốc độ G(s) [cite: 49]
num_v = Kt;
den_v = [J*L, (J*R + B*L), (R*B + Kt*Kb)];
Gs = tf(num_v, den_v);

% Hàm truyền vị trí Gp(s) = G(s) * (1/s) 
Gp = Gs * tf(1, [1 0]);

%% 2. Vẽ QĐNS và Tự động tìm thông số tới hạn (Kgh, Tgh)
figure;
rlocus(Gp); % Vẽ quỹ đạo nghiệm số để quan sát [cite: 94]
grid on;
title('Quỹ đạo nghiệm số của hệ thống vị trí Gp(s)');

% Tìm lề ổn định (Gain Margin) để xác định Kgh và tần số tới hạn w_gh
[Kgh, phase, w_gh, w_margin] = margin(Gp);

% Chu kỳ tới hạn Tgh [cite: 96]
Tgh = 2*pi / w_gh;

fprintf('--- Kết quả phân tích tới hạn ---\n');
fprintf('Hệ số tới hạn Kgh = %.4f\n', Kgh);
fprintf('Tần số tới hạn w_gh = %.4f (rad/s)\n', w_gh);
fprintf('Chu kỳ tới hạn Tgh = %.4f (s)\n', Tgh);

%% 3. Tính toán hệ số PID theo bảng Ziegler-Nichols 
Kp = 0.6 * Kgh;
Ti = 0.5 * Tgh;
Td = 0.125 * Tgh;

% Chuyển sang thông số Kp, Ki, Kd cho khối PID trong Simulink
Ki = Kp / Ti;
Kd = Kp * Td;

fprintf('\n--- Thông số bộ điều khiển PID (Ziegler-Nichols) ---\n');
fprintf('Kp = %.4f\n', Kp);
fprintf('Ki = %.4f\n', Ki);
fprintf('Kd = %.4f\n', Kd);

%% 4. Kiểm tra đáp ứng vòng kín (Tín hiệu đặt 10 rad) [cite: 109]
C_zn = pid(Kp, Ki, Kd);
T_cl = feedback(C_zn * Gp, 1);

figure;
h = stepplot(10 * T_cl); % Vẽ đáp ứng nấc biên độ 10 rad
grid on;
title('Đáp ứng bước nấc Vị trí (Z-N) - 10 rad');
% Sau khi chạy, bạn chuột phải vào hình chọn Characteristics để xem POT, tqd [cite: 111]