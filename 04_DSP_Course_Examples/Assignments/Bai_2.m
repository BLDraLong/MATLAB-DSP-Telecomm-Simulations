%% LAB 2: Wireless Channel Models
clc; clear; close all;
rng(1)

%% =========================
% PART A: Large-scale Path Loss
%% =========================

fc_MHz = 900;                 % Carrier frequency
d_km = linspace(0.1,5,200);   % Distance
d0_km = 0.1;

n = 3;                        % Path-loss exponent
sigma_shd = 6;                % Shadowing std (dB)

PL_d0 = fspl_dB(fc_MHz,d0_km);

Xsigma = sigma_shd*randn(size(d_km));

PL_simplified = PL_d0 + 10*n*log10(d_km/d0_km) + Xsigma;

figure
plot(d_km,PL_simplified,'LineWidth',2)
grid on
xlabel('Distance (km)')
ylabel('Path Loss (dB)')
title('Simplified Path Loss Model')

%% =========================
% PART B: Small-scale fading
%% =========================

N = 2e5;                  % Number of bits
bits = randi([0 1],N,1);

x = 2*bits-1;             % BPSK mapping
Ps = mean(abs(x).^2);

SNR_dB = -5:2:30;
SNR_lin = 10.^(SNR_dB/10);

%% Fading channels

% Rayleigh
h_ray = (randn(N,1)+1i*randn(N,1))/sqrt(2);

% Rician
K_dB = 6;
K = 10^(K_dB/10);

h_ric = sqrt(K/(K+1)) + sqrt(1/(K+1))*(randn(N,1)+1i*randn(N,1))/sqrt(2);

% Nakagami
m = 5;
h_nak = nakagami_fading(N,m);

%% =========================
% PDF & CDF
%% =========================

figure

subplot(1,2,1)

histogram(abs(h_ray),100,'Normalization','pdf','FaceColor','r','FaceAlpha',0.4); hold on
histogram(abs(h_ric),100,'Normalization','pdf','FaceColor','g','FaceAlpha',0.4)
histogram(abs(h_nak),100,'Normalization','pdf','FaceColor','b','FaceAlpha',0.4)

grid on
xlabel('|h|')
ylabel('PDF')
title('PDF of fading amplitude')

legend('Rayleigh','Rician','Nakagami-m')


subplot(1,2,2)

[f1,x1] = ecdf(abs(h_ray).^2);
[f2,x2] = ecdf(abs(h_ric).^2);
[f3,x3] = ecdf(abs(h_nak).^2);

plot(x1,f1,'r','LineWidth',2); hold on
plot(x2,f2,'g','LineWidth',2)
plot(x3,f3,'b','LineWidth',2)

grid on
xlabel('|h|^2')
ylabel('CDF')
title('CDF of fading power')

legend('Rayleigh','Rician','Nakagami-m')

%% =========================
% BER Simulation
%% =========================

for k = 1:length(SNR_dB)

Pn = Ps/SNR_lin(k);

n0 = sqrt(Pn/2)*(randn(N,1)+1i*randn(N,1));

%% Rayleigh
y = h_ray.*x + n0;

xhat = real(conj(h_ray).*y./(abs(h_ray).^2));

bits_hat = xhat>0;

BER_ray(k) = mean(bits_hat~=bits);

%% Rician
y = h_ric.*x + n0;

xhat = real(conj(h_ric).*y./(abs(h_ric).^2));

bits_hat = xhat>0;

BER_ric(k) = mean(bits_hat~=bits);

%% Nakagami
y = h_nak.*x + n0;

xhat = real(conj(h_nak).*y./(abs(h_nak).^2));

bits_hat = xhat>0;

BER_nak(k) = mean(bits_hat~=bits);

end

%% AWGN theoretical



%% =========================
% Plot BER
%% =========================

figure

semilogy(SNR_dB,BER_ray,'o-','Color','r','LineWidth',1.5); hold on
semilogy(SNR_dB,BER_ric,'s-','Color','g','LineWidth',1.5)
semilogy(SNR_dB,BER_nak,'^-','Color','b','LineWidth',1.5)



grid on
xlabel('SNR (dB)')
ylabel('BER')

title('BER BPSK: Rayleigh vs Rician vs Nakagami-m')

legend('Rayleigh','Rician','Nakagami-m','Location','southwest')