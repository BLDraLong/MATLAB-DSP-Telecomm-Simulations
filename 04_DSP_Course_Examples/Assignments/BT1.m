%---------------------------------
clear all; close all; clc;
%---------------------------------
w_s1= 0.2*pi; w_p1= 0.55*pi; 
w_s2= 0.75*pi; w_p2= 0.35*pi;
transition= min((w_p1- w_s1),(w_s2 -w_p2))
M=ceil(6.2*pi/transition)+1;n=[ 0:1:M-1];w_c1= (w_s1+w_p1)/2;w_c2= (w_s2+w_p2)/2;
hd=ideal_lp(w_c2,M)- ideal_lp(w_c1,M);w_hann=(hann(M))';h=hd.*w_hann;
[db,mag,pha,grd,w]=freqz_m(h,[1]);delta_w=2*pi/1000;
Rp=-min(db(w_p1/delta_w+1:1:w_p2/delta_w));
As=-round(max(db(w_s2/delta_w+1:1:501)));
subplot(2,2,1);
stem(n,hd); title('Ideal hd(n)');xlabel('n'); ylabel('hd(n)');axis([0 M-1 -0.1 0.3]);
subplot(2,2,2);
stem(n,w_hann);title('Hamming Window');xlabel('n'); ylabel('w(n)');axis([0 M-1 0 1.1]);
subplot(2,2,3); stem(n,h);title('Actual Impulse Response');
xlabel('n'); ylabel('h(n)');axis([0 M-1 -0.1 0.3]);
subplot(2,2,4);plot(w/pi,db);title('Magnituude Response in dB');grid
xlabel('frequency in pi units'); ylabel('Decibels');axis([0 1 -100 10]);


