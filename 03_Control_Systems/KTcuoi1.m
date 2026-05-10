num = [1];
den = [1, 8, 20, 0];
G = tf(num, den);

K = 47.7; 
T = feedback(K * G, 1);
t = 0:0.01:5;
figure;
step(T, t);
grid on;
title('Đáp ứng quá độ vòng kín của hệ thống');