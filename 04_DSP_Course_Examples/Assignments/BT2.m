%---------------------------------
clear all; close all; clc;
%---------------------------------
w_s1= 0.3*pi; w_p1= 0.4*pi; 
w_s2= 0.7*pi; w_p2= 0.6*pi;
transition= min((w_p1- w_s1),(w_s2 -w_p2)); 
M=ceil(6.6*pi/transition)+1;n=[ 0:1:M-1];w_c1= (w_s1+w_p1)/2;w_c2= (w_s2+w_p2)/2;
hd=ideal_lp(w_c2,M)- ideal_lp(w_c1,M);w_ham=(hamming(M))';h=hd.*w_ham;
[db,mag,pha,grd,w]=freqz_m(h,[1]);delta_w=2*pi/1000;
Rp=0.2;
As= 50;
subplot(2,2,1);
stem(n,hd); title('Ideal hd(n)');xlabel('n'); ylabel('hd(n)');axis([0 M-1 -0.1 0.3]);
subplot(2,2,2);
stem(n,w_ham);title('Hamming Window');xlabel('n'); ylabel('w(n)');axis([0 M-1 0 1.1]);
subplot(2,2,3); stem(n,h);title('Actual Impulse Response');
xlabel('n'); ylabel('h(n)');axis([0 M-1 -0.1 0.3]);
subplot(2,2,4);plot(w/pi,db);title('Magnituude Response in dB');grid
xlabel('frequency in pi units'); ylabel('Decibels');axis([0 1 -100 10]);