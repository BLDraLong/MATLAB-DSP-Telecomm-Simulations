%% 1. Khai báo thông số
R = 0.55; L = 0.302; Kb = 0.0185; 
J = 0.041; B = 0.022; Kt = 0.069;

%% 2. Thiết lập ma trận PTTT
A = [-B/J, Kt/J; -Kb/L, -R/L];
b = [0; 1/L];
C = [1, 0];
D = 0;
sys = ss(A, b, C, D);

%% 3. Đánh giá tính điều khiển được
sys_order = order(sys);
R_matrix = ctrb(A, b);
sys_rank = rank(R_matrix);

fprintf('Bac cua he thong: %d\n', sys_order);
fprintf('Hang cua ma tran R: %d\n', sys_rank);

if sys_rank == sys_order
    disp('He thong dieu khien duoc -> Co the dung phuong phap dat cuc.');
else
    disp('He thong khong dieu khien duoc.');
end

%% 4. Tính toán vector hoi tiep K
% Yeu cau: xi = 0.5, wn = 25
xi = 0.5; wn = 25;
% Phuong trinh dac trung mong muon: s^2 + 2*xi*wn*s + wn^2 = 0
poles = roots([1, 2*xi*wn, wn^2]); % Tim cac cuc mong muon

K = place(A, b, poles); % Tinh vector K

fprintf('\nVector hoi tiep trang thai K:\n');
disp(K);