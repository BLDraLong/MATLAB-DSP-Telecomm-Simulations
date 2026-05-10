% 1. Khai báo hàm truyền vòng hở G(s) cơ bản
num = 1;
den = conv([1 3], [1 8 20]);
G_ho = tf(num, den);

% 2. Khai báo các giá trị K đã tìm được
Kb = 76.9; % Giá trị K cho câu b
Kc = 172;  % Giá trị K cho câu c

% 3. Khai báo các khối khuếch đại K (hàm truyền hằng số)
G_kb = tf(Kb, 1);
G_kc = tf(Kc, 1);

% 4. Khai báo các hệ thống tiến (nối tiếp K và G_ho)
G_tien_b = series(G_kb, G_ho);
G_tien_c = series(G_kc, G_ho);

% 5. Khai báo các hàm truyền vòng kín (feedback với H = 1)
H = 1;
G_kin_b = feedback(G_tien_b, H);
G_kin_c = feedback(G_tien_c, H);

% 6. Vẽ đáp ứng quá độ trên cùng một hình vẽ trong khoảng 0-5s
figure;
step(G_kin_b, 5); 
hold on;          
step(G_kin_c, 5); 
grid on;

% 7. Đặt tiêu đề và nhãn trục
title('So sanh dap ung qua do: K = 76.9 va K = 172');
xlabel('Thoi gian (s)');
ylabel('Bien do');