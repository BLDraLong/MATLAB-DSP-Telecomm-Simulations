% Gán K = 424
K = 424;

% Viết trực tiếp đa thức tử số và mẫu số của hệ kín
% G_kin = K / (s^3 + 11s^2 + 44s + 60 + K)
num_kin = K;
den_kin = [1, 11, 44, 60 + K];

% Khai báo hàm truyền hệ kín
G_kin = tf(num_kin, den_kin);

% Vẽ đáp ứng quá độ với đầu vào hàm nấc đơn vị
figure;
step(G_kin, 20); % Vẽ trong 20 giây để thấy rõ dao động
grid on;
title('Dap ung qua do he thong vong kin voi K = 424');
xlabel('Thoi gian (s)');
ylabel('Bien do');