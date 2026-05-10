clc;clear all; close all;
n=-10:10;x= (0.9.^n).^n;k= -200:200;w=(pi/100)*k;
X=x*(exp(-j*pi/100)).^(n'*k);
magX= abs(X); angX= angle(X)
subplot(2,1,1);plot(w/pi,magX);grid;axis([-2,2,0,15])
xlabel('frequency in pi units'); title ('Magnitude Part'); ylabel('|X|')
subplot(2,1,2);plot(w/pi,angX/pi) ; grid; axis([-2,2,-1,1])
xlabel('frequency in pi units'); title ('Angle Part'); ylabel('radians/pi');
k=0:200;X_reversed= conj(X(201-k));%X(201-k)
X_conjugate= X(201+k);%X*(201+k)
error =norm(X_reversed-X_conjugate);% Tinh sai so chuan
disp(['Norm of the error:',num2str(error)]);