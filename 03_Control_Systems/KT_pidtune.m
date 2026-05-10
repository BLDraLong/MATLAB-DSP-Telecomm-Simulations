R = 1.93; 
L = 0.275; 
Kb = 0.0289; 
J = 0.039; 
B = 0.092; 
Kt = 0.041;

num = Kt;
den = [J*L, (J*R + B*L), (R*B + Kt*Kb)];
G = tf(num, den);
[C_tune_pos, info] = pidtune(G, 'PID');

% Hiển thị thông số tìm được
fprintf('--- Thông số PID (pidtune) cho Vị trí ---\n');
disp(C_tune_pos);
