%% BƯỚC 1: Tạo tín hiệu x(n)
N = 100; % Số mẫu tín hiệu.
n = 0:N-1; % Chỉ số mẫu

% Các tần số góc
w1 = pi/7;
w2 = 2*pi/7;
w3 = 3*pi/7;

% Tạo tín hiệu x(n) với ba thành phần tần số
x = cos(w1 * n) + cos(w2 * n) + cos(w3 * n);

%% BƯỚC 2: Biểu diễn phổ DTFT của x(n) không dùng FFT
w = linspace(0, pi, 501); % Trục tần số từ 0 đến pi
X_w = zeros(size(w)); % Khởi tạo phổ

for k = 1:length(w)
    X_w(k) = sum(x .* exp(-1j * w(k) * n)); % Tính DTFT theo công thức tổng
end

figure;
subplot(2,2,1);
plot(w/pi, abs(X_w), 'b', 'LineWidth', 1.5);
xlabel('Tần số (×π rad/mẫu)');
ylabel('Biên độ');
title('Phổ DTFT của tín hiệu x(n)');
grid on;

%% BƯỚC 3: Thiết kế bộ lọc High-Pass loại bỏ w1
M = 51; % Bậc bộ lọc FIR (số lẻ)
w_c = w1 + 0.05*pi; % Tần số cắt

h_lp = ideal_lp(w_c, M); % Bộ lọc thông thấp lý tưởng
h_hp = -h_lp; % Đảo dấu để tạo bộ lọc thông cao
h_hp(floor(M/2)+1) = 1 + h_hp(floor(M/2)+1); % Điều chỉnh đáp ứng xung tại vị trí trung tâm

% Áp dụng cửa sổ Blackman
window = blackman(M)';
h_hp = h_hp .* window;

% Lọc tín hiệu
x_hp = conv(x, h_hp, 'same');

% Tính phổ sau lọc High-Pass không dùng FFT
X_hp = zeros(size(w));
for k = 1:length(w)
    X_hp(k) = sum(x_hp .* exp(-1j * w(k) * n));
end

subplot(2,2,2);
plot(w/pi, abs(X_hp), 'r', 'LineWidth', 1.5);
xlabel('Tần số (×π rad/mẫu)');
ylabel('Biên độ');
title('Phổ sau lọc High-Pass (loại bỏ w_1)');
grid on;

%% BƯỚC 4: Hiển thị phổ DTFT của bộ lọc High-Pass
H_hp = zeros(size(w));
for k = 1:length(w)
    H_hp(k) = sum(h_hp .* exp(-1j * w(k) * (0:M-1)));
end

subplot(2,2,3);
plot(w/pi, abs(H_hp), 'g', 'LineWidth', 1.5);
xlabel('Tần số (×π rad/mẫu)');
ylabel('Biên độ');
title('Phổ DTFT của bộ lọc High-Pass');
grid on;
