% Tạo tín hiệu x(n)
N = 100; % Độ dài tín hiệu
n = 0:N-1;
w1 = pi/7;
w2 = 2*pi/7;
w3 = 3*pi/7;
x = cos(w1*n) + cos(w2*n) + cos(w3*n);

% Tính toán DTFT trực tiếp
w = linspace(0, 2*pi, 1000); % Tần số từ 0 đến 2*pi
X = zeros(size(w));
for k = 1:length(w)
    X(k) = sum(x .* exp(-1j*w(k)*n));
end

% Thiết kế bộ lọc thông cao
fc = (w1 + w2) / 2; % Tần số cắt
order = 50; % Bậc của bộ lọc
b = fir1(order, fc/pi, 'high'); % Thiết kế bộ lọc FIR thông cao

% Tính toán phổ DTFT của bộ lọc (tính toán trực tiếp)
H = zeros(size(w));
for k = 1:length(w)
    H(k) = sum(b .* exp(-1j*w(k)*(0:order)));
end

% Lọc tín hiệu x(n)
y = filter(b, 1, x);

% Tính toán phổ DTFT của tín hiệu sau lọc (tính toán trực tiếp)
Y = zeros(size(w));
for k = 1:length(w)
    Y(k) = sum(y .* exp(-1j*w(k)*n));
end

% Phổ DTFT của x(n)
subplot(2,2,1);
plot(w/pi, abs(X));
title('Phổ DTFT của x(n)');
xlabel('Tần số chuẩn hóa (pi rad/mẫu)');
ylabel('|X(w)|');

% Phổ DTFT của bộ lọc thông cao
subplot(2, 2, 2);
plot(w/pi, abs(H));
title('Phổ DTFT của bộ lọc thông cao');
xlabel('Tần số chuẩn hóa (pi rad/mẫu)');
ylabel('|H(w)|');

% Phổ DTFT của tín hiệu sau lọc y(n)
subplot(2, 2, 3);
plot(w/pi, abs(Y));
title('Phổ DTFT của tín hiệu sau lọc y(n)');
xlabel('Tần số chuẩn hóa (pi rad/mẫu)');
ylabel('|Y(w)|');

