clc;clear all;close all;n= [-10:1:10];alpha=-0.1+0.3j;x=exp(alpha*n);
t=tiledlayout(2,2,'TileSpacing','Compact','Padding','Compact');
nexttile;stem(n,real(x),'LineWidth',1);title('real part');xlabel('n')
nexttile; stem(n,imag(x),'LineWidth',1);title('imaginary part');xlabel('n')
nexttile; stem(n,abs(x),'LineWidth',1);title('magnitude part');xlabel('n')
nexttile; stem(n,(180/pi)*angle(x),'LineWidth',1);title('phase part');xlabel('n')