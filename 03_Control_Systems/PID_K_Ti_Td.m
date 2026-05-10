%% Bước 1: Khai báo các thông số của hệ thống (Transfer Function)
% Dựa trên hình 2 và hình 3
s = tf('s');
num = 100;
% den = conv([364 1], [1495 1]); % Cách khai báo theo mảng hệ số
G = 100 / ((364*s + 1) * (1495*s + 1));

disp('Hàm truyền đối tượng G(s):');
printsys(num, [364*1495, 364+1495, 1]); % Hiển thị hàm truyền tường minh

%% Bước 2: Tính toán tham số PID
% CÁCH 1: Tính thủ công theo công thức (Hình 1)
% Lưu ý: Bạn có thể thay đổi T1, T2 tùy theo đề bài cụ thể
K = 100; 
T1_manual = 183; 
T2_manual = 2535; 

Kp_manual = 1.2 * T2_manual / (T1_manual * K);
Ti = 2 * T1_manual;
Td = 0.5 * T1_manual;

Ki_manual = Kp_manual / Ti;
Kd_manual = Kp_manual * Td;

% CÁCH 2: Sử dụng lệnh pidtune của MATLAB (Hình 2)
C_auto = pidtune(G, 'PID');
Kp_auto = C_auto.Kp;
Ki_auto = C_auto.Ki;
Kd_auto = C_auto.Kd;

%% Bước 3: Hiển thị kết quả so sánh
disp('--- Tham số PID tính thủ công (Hình 1) ---');
fprintf('Kp = %.5f \nKi = %.5f \nKd = %.5f \n', Kp_manual, Ki_manual, Kd_manual);

disp('--- Tham số PID tự động tune (Hình 2) ---');
fprintf('Kp = %.5f \nKi = %.5f \nKd = %.5f \n', Kp_auto, Ki_auto, Kd_auto);

%% Bước 4: Thiết lập bộ điều khiển và Mô phỏng (Hình 3)
% Chọn bộ tham số bạn muốn mô phỏng (ở đây tôi chọn bộ PID tự động)
PID_ctrl = Kp_manual + Ki_manual/s + Kd_manual*s;

% Hàm truyền vòng kín
H = feedback(PID_ctrl * G, 1);

% Vẽ đáp ứng bước (Step Response)
figure;
step(H, 10000); % Mô phỏng trong 5000 giây
title('Đáp ứng bước của hệ thống PID vòng kín');
xlabel('Thời gian (s)');
ylabel('Biên độ (Nhiệt độ)');
grid on;