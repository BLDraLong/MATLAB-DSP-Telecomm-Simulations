clc;clear all; close all;
b=[1,0];a=[1,-0.9];
[H,w]=freqz(b,a,100);
magH= abs(H); angH= angle(H);
subplot(2,1,1);plot(w/pi,magH);grid
xlabel('frequency in pi units'); title ('Magnitude Part'); ylabel('Magnitude')
subplot(2,1,2);plot(w/pi,angH/pi) ; grid
xlabel('frequency in pi units'); title ('Phase in pi units'); ylabel('Phase Response')