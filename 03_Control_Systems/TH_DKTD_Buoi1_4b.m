% 1. Khai báo hàm truyền vòng hở G(s) cơ bản (với K=1)
num = 1;
den = conv([1 3], [1 8 20]); 
G_ho = tf(num, den);

% 2. Khai báo khối khuếch đại K (hàm truyền hằng số)
K_d = 76.9;
G_k = tf(K_d, 1); 

% 3. Khai báo hàm truyền nối tiếp của hệ thống tiến (Open Loop Forward)
G_tien = series(G_k, G_ho);

% 4. Khai báo hàm truyền vòng kín với hồi tiếp âm đơn vị (H = 1)
H = 1;
G_kin = feedback(G_tien, H);

% 5. Vẽ đáp ứng quá độ trong khoảng 0-5s
figure;
step(G_kin, 5);
grid on;
title('Dap ung qua do he thong vong kin voi K = 76.9');