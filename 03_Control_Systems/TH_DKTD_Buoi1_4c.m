% 1. Khai báo hàm truyền vòng hở G(s) cơ bản
num = 1;
den = conv([1 3], [1 8 20]); 
G_ho = tf(num, den);

% 2. Khai báo khối khuếch đại K = 172 (tìm được ở câu e)
K_e = 172;
G_k = tf(K_e, 1); 

% 3. Khai báo hệ thống tiến (nối tiếp K và G_ho)
G_tien = series(G_k, G_ho);

% 4. Khai báo hệ thống vòng kín hồi tiếp âm đơn vị (H = 1)
H = 1;
G_kin = feedback(G_tien, H);

% 5. Vẽ đáp ứng quá độ trong khoảng thời gian t = 0-5s
figure;
step(G_kin, 5);
grid on;
title('Dap ung qua do he thong vong kin voi K = 172');