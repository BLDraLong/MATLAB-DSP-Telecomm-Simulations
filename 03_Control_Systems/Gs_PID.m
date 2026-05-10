%% 1. Khai báo thông số hệ thống 
R = 0.55; 
L = 0.302; 
Kb = 0.0185; 
J = 0.041; 
B = 0.022; 
Kt = 0.069;

%% 2. Thiết lập hàm truyền G(s)
% G(s) = Kt / (J*L*s^2 + (J*R + B*L)*s + (R*B + Kt*Kb))
num = Kt;
den = [J*L, (J*R + B*L), (R*B + Kt*Kb)];
G = tf(num, den);

% Hiển thị hàm truyền ra màn hình
fprintf('Hàm truyền G(s) của động cơ:\n');
disp(G);

%% 3. Thông số thiết kế mong muốn
zeta = 0.6;
wn = 25;
Kv = 100;

%% 4. Tính toán các hệ số PID (Phương pháp đại số)
a = den(1); 
b = den(2); 
c = den(3);

% Tính KI dựa trên hệ số vận tốc Kv
KI = (Kv * c) / Kt;

% Tìm alpha từ phương trình đặc trưng bậc 3
% alpha * wn^2 = (KI * Kt) / a
alpha = (KI * Kt / a) / (wn^2);

% Tính KP và KD bằng phương pháp cân bằng hệ số
% Hệ số s^2: (b + Kt*KD)/a = alpha + 2*zeta*wn
KD = (a * (alpha + 2*zeta*wn) - b) / Kt;

% Hệ số s^1: (c + Kt*KP)/a = wn^2 + 2*zeta*wn*alpha
KP = (a * (wn^2 + 2*zeta*wn*alpha) - c) / Kt;

%% 5. Hiển thị kết quả tính toán
fprintf('--- Kết quả tính toán hệ số PID ---\n');
fprintf('alpha = %.4f\n', alpha);
fprintf('KP    = %.4f\n', KP);
fprintf('KI    = %.4f\n', KI);
fprintf('KD    = %.4f\n', KD);

%% 6. Kiểm tra đáp ứng
GPID = tf([KD KP KI], [1 0]);
T = feedback(GPID*G, 1);
step(10*T);
title('Đáp ứng nấc thang tốc độ (10 rad/s)');
grid on;