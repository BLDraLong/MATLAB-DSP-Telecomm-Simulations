clc; clear all; close all
x = [3, 11, 7, 0, -1, 4, 2]; % given signal x
nx = [-3:3]; % obtain signal n
[y,ny]=dichchuyen_tinhieu(x,nx,2);%obtain x(n-2)
w = randn(1, length(y));nw=ny; % generate w
[y,ny]=cong_2tinhieu(y,ny,w,nw);%obtain y(n)=x(n-2)+w(n)
[x,nx]=gap_tinhieu(x,nx);[rxy,nrxy]=conv_m(y,ny,x,nx);%crosscorrelation
subplot(1, 1, 1);subplot(2,1,1); stem(nrxy, rxy); axis([-5,10,-50,250]); 
xlabel('lag variable l'); 
ylabel('rxy'); title('Crosscorrelation: noise sequence 1');