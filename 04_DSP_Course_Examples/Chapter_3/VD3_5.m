clc;clear all; close all;
n=0:10;x= (0.9*exp(j*pi/3)).^n;k= -200:200;w=(pi/100)*k;
X=x*(exp(-j*pi/100)).^(n'*k);
magX= abs(X); angX= angle(X)
subplot(2,1,1);plot(w/pi,magX);grid
xlabel('frequency in pi units'); title ('Magnitude Part'); ylabel('|X|')
subplot(2,1,2);plot(w/pi,angX/pi) ; grid
xlabel('frequency in pi units'); title ('Real Part'); ylabel('Angle Part');
bb=X(201:400);
aa=X(1:200);
error=sum (abs(aa-bb))