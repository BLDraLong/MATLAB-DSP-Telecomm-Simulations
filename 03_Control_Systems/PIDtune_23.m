%% 1. Thông số động cơ (STT 0) và Hàm truyền vị trí Gp(s)
R = 1.75; L = 0.212; Kb = 0.0246; 
J = 0.052; B = 0.075; Kt = 0.052;

% Hàm truyền tốc độ G(s)
num = Kt;
den = [J*L, (J*R + B*L), (R*B + Kt*Kb)];
Gs = tf(num, den);

% Hàm truyền vị trí Gp(s) = G(s) * (1/s) [cite: 89]
Gp = Gs * tf(1, [1 0]);

%% 2. Thiết kế PID bằng hàm pidtune cho Gp(s) 
% MATLAB sẽ tự động tìm bộ Kp, Ki, Kd tối ưu cho hệ điều khiển vị trí
[C_tune_pos, info] = pidtune(Gp, 'PID');

% Hiển thị thông số tìm được
fprintf('--- Thông số PID (pidtune) cho Vị trí ---\n');
disp(C_tune_pos);

%% 3. Tạo hệ thống vòng kín và Vẽ đáp ứng
% Tín hiệu đặt là 10 rad theo yêu cầu [cite: 109]
T_cl_tune = feedback(C_tune_pos * Gp, 1);

figure;
h = stepplot(10 * T_cl_tune); % Sử dụng stepplot để có menu Characteristics
grid on;
title('Đáp ứng Vị trí (Thiết kế bằng pidtune) - 10 rad');

% Hướng dẫn: Chuột phải vào hình -> Characteristics -> Chọn các thông số để so sánh