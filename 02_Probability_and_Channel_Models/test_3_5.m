clc; clear; close all;

%% 1. Thiet lap thong so khong gian va he thong
Pt_dBm = 43;          % Cong suat phat cua tram (dBm) - khoang 20W
fc_MHz = 900;         % Tan so hoat dong (MHz)
P_th = -85;           % Nguong thu nhay cua may thu (dBm) - Duoi muc nay coi nhu mat song

% Tao luoi toa do 2D (Grid) tu -5km den 5km cho truc X va Y
x = linspace(-5, 5, 200); 
y = linspace(-5, 5, 200);
[X, Y] = meshgrid(x, y);

% Tinh khoang cach tu tram phat (0,0) den moi diem tren luoi
d_km = sqrt(X.^2 + Y.^2);
d_km(d_km < 0.1) = 0.1; % Tranh loi chia cho 0 o tam tram phat

%% 2. Tinh toan Suy hao (Path Loss) va Cong suat thu
% Su dung mo hinh Simple Path Loss (FSPL) nhu code truoc cua ban
PL_simplified = 32.45 + 20*log10(fc_MHz) + 20*log10(d_km);

% Them nhieu Shadowing (Log-normal fading) de mo phong vat can thuc te
sigma_shadow = 6; % Do lech chuan cua nhieu (dB)
shadowing = sigma_shadow * randn(size(d_km));

% Cong suat thu (Rx Power) = Cong phat - Suy hao - Shadowing
Prx_dBm = Pt_dBm - PL_simplified - shadowing;

%% 3. Ve bieu do Vung phu song
figure;

% Ve Heatmap (ban do nhiet) the hien muc do manh yeu cua tin hieu
imagesc(x, y, Prx_dBm);
set(gca, 'YDir', 'normal'); % Chuan hoa lai truc Y tu duoi len tren
colormap('jet');            % Chon ban mau (Xanh: yeu, Do: manh)
c = colorbar;
c.Label.String = 'Cong suat thu (dBm)';

hold on;
% Ve danh dau vi tri Tram phat trung tam
plot(0, 0, 'k^', 'MarkerFaceColor', 'k', 'MarkerSize', 10);

% Ve duong vien vung phu song hieu qua (Vung nhan duoc song >= P_th)
contour(X, Y, Prx_dBm, [P_th P_th], 'w-', 'LineWidth', 2);

xlabel('Khoang cach truc X (km)');
ylabel('Khoang cach truc Y (km)');
title('Bieu do Vung Phu Song (Coverage Map)');
legend('Tram phat (BS)', sprintf('Ranh gioi phu song (%d dBm)', P_th), 'Location', 'northeast');
hold off;

set(gcf, 'color', 'w');