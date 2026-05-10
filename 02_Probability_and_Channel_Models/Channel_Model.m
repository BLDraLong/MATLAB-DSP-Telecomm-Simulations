clc;
clear;
close all;

rng(1);

%% ======================

%Phần A: Large-scale path loss

% =======================

fc_MHz=900;     %tần số sóng mang (MHz) - tuỳ ch�?n 900/1800/2100,...
d_km = linspace(0.1, 5, 200); %khoang cách (km)
d0_km = 0.1;
n= 4;         % hệ số suy hao (pathloss exponent)
sigma_shd=6;    % độ lệch chuẩn shadowing (dB), nếu không muốn n=0

%---Simplified model (tham chiếu từ FSPL tai d0)
PL_do=fspl_dB(fc_MHz,d0_km);    %FSPL tại d0
Xsigma = sigma_shd * randn(size(d_km)); %shadowing(tuỳ ch�?n)
PL_simplified= PL_do + 10*n*log10(d_km/d0_km) + Xsigma;
PL_awgn=PL_do + 10*n*log10(d_km/d0_km);

%--Okumura (placeholder)
%PL_okumura=okumura_model(fc_MHz, d_km,...)
PL_okumura=nan(size(d_km));

%--- Walfisch/Bertoni(placeholder)
%PL_wb=walfisch_bertoni_model(fc_MHz, d_km,...)
PL_wb=nan(size(d_km));

% ====== Rayleigh fading (C�ch 1) ======
lambda_h = 2; % c�ng su?t trung b�nh k�nh (c� th? ?? 1)

h = sqrt(lambda_h/2) .* (randn(size(d_km)) + 1i*randn(size(d_km)));

rayleigh_linear = abs(h).^2;

F_rayleigh_dB = 10*log10(rayleigh_linear);

PL_rayleigh = PL_simplified + F_rayleigh_dB;
% �p v�o path loss
PL_rayleigh = PL_awgn + F_rayleigh_dB;


figure;
plot(d_km, PL_simplified, "LineWidth",1.5); hold on;
plot(d_km, PL_awgn, "--", "LineWidth",1.2);
plot(d_km, PL_rayleigh, ":", "LineWidth",1.2);

grid on;
xlabel('Khoang cach d (km)');
ylabel('Path loss (dB)');
title('So sanh: Path loss + AWGN + Rayleigh');
legend('Simplified','AWGN','Reyleigh','Location','best');




%%=====================================

%Phan B:Small-scale fading + BER

%======================================

N=2e5;  %số bit
bits = randi([0 1], N, 1);
x=2*bits-1;     %BPSK(+1/-1)
Ps =mean(abs(x)/2);

SNR_dB = -5:2:30;
SNR_lin = 10.^(SNR_dB/10);

% Tạo fading
h_ray = (randn(N,1)+1j*randn(N,1))/sqrt(2);

K_dB = 6; %Ricium K-factor(dB)
K= 10^(K_dB/10);


h_ric=sqrt(K/(K+1))+sqrt(1/(K+1))*(randn(N,1)+ 1j*randn(N,1))/sqrt(2);


m=10; %Nakagami-m
h_nak = nakagami_fading (N, m);
% Ve PDF/CDF biên độ
figure;
subplot(1,2,1);
histogram(abs(h_ray),100,'Normalization','pdf'); hold on;
histogram(abs(h_ric),100,'Normalization','pdf');
histogram(abs(h_nak),100,'Normalization','pdf');
grid on; xlabel('|h|'); ylabel('PDF'); title('PDF Bien do fading');
legend('Rayleigh', 'Riciant', 'Nakagami-m');

subplot(1,2,2);
[f1,x1]=ecdf(abs(h_ray).^2);
[f2,x2]= ecdf(abs(h_ric).^2);
[f3,x3]=ecdf(abs(h_nak).^2);
plot(x1,f1,'LineWidth',1.5); hold on;
plot(x2,f2,'LineWidth',1.5);
plot(x3,f3,'LineWidth',1.5);
grid on; xlabel('|h|^2'); ylabel('CDF'); title('CDF cong suat fading');

%BER
BER_ray=zeros(size(SNR_dB));
BER_ric = zeros(size(SNR_dB));
BER_nak = zeros(size(SNR_dB));

for k= 1 : length(SNR_dB)
    Pn = Ps/SNR_lin(k);
    n0 = sqrt(Pn/2)*(randn(N,1)+1j*randn(N,1)); %AWGN phuc

%rayleigh
y=h_ray.*x+n0;
xhat=real(y./h_ray);    %equalize (gia su biet h)
bits_hat= xhat >0;
BER_ray(k)= mean(bits_hat~=bits);

%Rician
y=h_ric.*x+n0;
xhat=real(y./h_ric);
bits_hat= xhat >0;
BER_ric(k)= mean(bits_hat~=bits);

%Nakagami

y= h_nak.*x+n0;
xhat=real(y./h_nak);
bits_hat= xhat >0;
BER_nak(k)= mean(bits_hat~=bits);
end

figure;
semilogy(SNR_dB, BER_ray,'o-','LineWidth',1.5);hold on;
semilogy(SNR_dB, BER_ric,'*-','LineWidth',1.5);
semilogy(SNR_dB, BER_nak,'x-','LineWidth',1.5);
grid on; xlabel('SNR (dB)'); ylabel('BER');
title('BER BPSK: Rayleigh vs Rician vs Nakagami-m');
legend('Rayleigh', 'Rician', 'Nakagami-m','Location','northwest');











