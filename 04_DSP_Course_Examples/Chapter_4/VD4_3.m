%---------------------------------
clear all; close all; clc;
%---------------------------------
wp= 0.2*pi; ws= 0.3*pi; tr_width= ws-wp; As= 50;
M=ceil((As-7.95)/(2.285*tr_width)+1)+1;n=[0:1:M-1];beta= 0.1102*(As-8.7);
wc= (ws+wp)/2;hd=ideal_lp(wc,M);
w_kai= (kaiser(M,beta))';h=hd.*w_kai;
[db,mag,pha,grd,w]= freqz_m(h,[1]);delta_w = 2*pi/1000;
As=-round(max(db(ws/delta_w+1:1:501)))%Min Stopband Attenuation
subplot(2,2,1);
stem(n,hd,'b'); title('Ideal Impulse Response');xlabel('n'); ylabel('hd(n)');axis([0 M-1 -0.1 0.3]);
subplot(2,2,2);
stem(n,w_kai,'b');title('Kaiser Window');xlabel('n'); ylabel('w(n)');axis([0 M-1 0 1.1]);
subplot(2,2,3); stem(n,h);title('Actual Impulse Response');
xlabel('n'); ylabel('h(n)');axis([0 M-1 -0.1 0.3]);
subplot(2,2,4);plot(w/pi,db,'b');title('Magnituude Response in dB');grid
xlabel('frequency in pi units'); ylabel('Decibels');axis([0 1 -100 10]);
