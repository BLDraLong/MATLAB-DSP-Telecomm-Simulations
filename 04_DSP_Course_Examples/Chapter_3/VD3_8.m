clc;clear all; close all;
n=0:100;x= cos(pi*n/2);k= -100:100;w=(pi/100)*k; %frequencybetween -pi and +pi
X=x*(exp(-j*pi/100)).^(n'*k);                    %DTFT of x%
y= exp(j*pi*n/4).*x;                             %signal multiplied by exp(j*pi*n/4)
Y=y*(exp(-j*pi/100)).^(n'*k);                    %DTFT of y
%Graphical verification
subplot(2,2,1);plot(w/pi,abs(X));grid;axis([-1,1,0,60])
xlabel('frequency in pi units'); title ('Magnitude Part'); ylabel('|X|')
subplot(2,2,2);plot(w/pi,angle(X)/pi) ; grid;axis([-1,1,-1,1])
xlabel('frequency in pi units'); title ('Angle of X'); ylabel('radians/pi')
subplot(2,2,3);plot(w/pi,abs(Y)) ; grid;axis([-1,1,0,60])
xlabel('frequency in pi units'); title ('Magnitude Part'); ylabel('|Y|');
subplot(2,2,4);plot(w/pi,angle(Y)/pi) ; grid;axis([-1,1,-1,1])
xlabel('frequency in pi units'); title ('Angle of Y'); ylabel('radians/pi')
error=sum(abs(X(1:end-25)-Y(26:end)))/length(X(1:end-25))