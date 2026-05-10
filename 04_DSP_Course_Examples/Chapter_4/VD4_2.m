clear all; close all; clc;
wp= 0.2*pi; ws= 0.3*pi; transition= ws-wp;
M=ceil(6.6*pi/transition)+1;n=[ 0:1:M-1];wc =(ws+wp)/2;
hd=ideal_lp(wc,M);w_ham=(hamming(M))';h=hd.*w_ham;
[db,mag,pha,grd,w]=freqz_m(h,[1]);delta_w=2*pi/1000;
Rp=-(min(db(1:1:wp/delta_w+1)));
As= -round(max(db(ws/delta_w+1:1:501)))
subplot(2,2,1);
stem(n,hd); title('Ideal hd(n)');xlabel('n'); ylabel('hd(n)');axis([0 M-1 -0.1 0.3]);
subplot(2,2,2);
stem(n,w_ham);title('Hamming Window');xlabel('n'); ylabel('w(n)');axis([0 M-1 0 1.1]);
subplot(2,2,3); stem(n,h);title('Actual Impulse Response');
xlabel('n'); ylabel('h(n)');axis([0 M-1 -0.1 0.3]);
subplot(2,2,4);plot(w/pi,db);title('Magnituude Response in dB');grid
xlabel('frequency in pi units'); ylabel('Decibels');axis([0 1 -100 10]);
