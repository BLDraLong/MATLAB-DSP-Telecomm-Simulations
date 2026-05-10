R = 1.93; 
L = 0.275; 
Kb = 0.0289; 
J = 0.039; 
B = 0.092; 
Kt = 0.041;

num = Kt;
den = [J*L, (J*R + B*L), (R*B + Kt*Kb)];
G = tf(num, den);

fprintf('Hàm truyền G(s) của động cơ:\n');
disp(G);

zeta = 0.6;
wn = 25;
Kv = 100;

a = den(1); 
b = den(2); 
c = den(3);

KI = (Kv * c) / Kt;

alpha = (KI * Kt / a) / (wn^2);

KD = (a * (alpha + 2*zeta*wn) - b) / Kt;

KP = (a * (wn^2 + 2*zeta*wn*alpha) - c) / Kt;

fprintf('--- Kết quả tính toán hệ số PID ---\n');
fprintf('alpha = %.4f\n', alpha);
fprintf('KP    = %.4f\n', KP);
fprintf('KI    = %.4f\n', KI);
fprintf('KD    = %.4f\n', KD);

GPID = tf([KD KP KI], [1 0]);
T = feedback(GPID*G, 1);
step(10*T);
title('Đáp ứng (10 rad/s)');
grid on;