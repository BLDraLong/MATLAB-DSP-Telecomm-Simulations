clc;clear all; close all;
n=-1:3;x= 1:5;k= 0:500;w=[0:1:500]*pi/500;%([0,pi])axis dividd into 501 points.w là omega .
H= exp(j*w)./ (exp(j*w) - 0.9*ones(1,501));
magH= abs(H); angH= angle(H);
subplot(2,1,1);plot(w/pi,magH);grid
xlabel('frequency in pi units'); title ('Magnitude Response'); ylabel('|H|')
subplot(2,1,2);plot(k/500,angH/pi) ; grid
xlabel('frequency in pi units'); title ('Phase Response'); ylabel('Phase in pi Radians')