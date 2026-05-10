%---------------------------------
clear all; close all; clc;
%---------------------------------
wp= 0.6*pi; ws= 0.4*pi; transition= wp-ws;As=50;Rp=0.0004
M=ceil(6.6*pi/transition)+1;n=[ 0:1:M-1];wc =(ws+wp)/2;
hd=ideal_lp(wc,M);w_ham=(hamming(M))';h=hd.*w_ham;
[db,mag,pha,grd,w]=freqz_m(h,[1]);delta_w=2*pi/1000;

subplot(2,2,1);
stem(n,hd); title('Ideal hd(n)');xlabel('n'); ylabel('hd(n)');axis([0 M-1 -0.1 0.3]);
subplot(2,2,2);
stem(n,w_ham);title('Hamming Window');xlabel('n'); ylabel('w(n)');axis([0 M-1 0 1.1]);
subplot(2,2,3); stem(n,h);title('Actual Impulse Response');
xlabel('n'); ylabel('h(n)');axis([0 M-1 -0.1 0.3]);
subplot(2,2,4);plot(w/pi,db);title('Magnituude Response in dB');grid
xlabel('frequency in pi units'); ylabel('Decibels');axis([0 1 -100 10]);
