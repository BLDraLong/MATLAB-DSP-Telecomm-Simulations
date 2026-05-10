clc;clear all; close all;
n=-1:3;x= 1:5;k= 0:500;w=(pi/500)*k;
X=x*(exp(-j*pi/500)).^(n'*k);
magX= abs(X); angX= angle(X);realX=real(X);imagX= imag(X);
subplot(2,2,1);plot(k/500,magX);grid
xlabel('frequency in pi units'); title ('Magnitude Part'); ylabel('Magnitude')
subplot(2,2,3);plot(k/500,angX) ; grid
xlabel('frequency in pi units'); title ('Angle Part'); ylabel('Radians')
subplot(2,2,2);plot(k/500,realX) ; grid
xlabel('frequency in pi units'); title ('Real Part'); ylabel('Reals');
subplot(2,2,4);plot(k/500,imagX) ; grid
xlabel('frequency in pi units'); title ('Imaginary Part'); ylabel('Imaginary')