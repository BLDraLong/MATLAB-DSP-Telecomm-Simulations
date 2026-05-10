%---------------------------------
clear all; close all; clc;
%---------------------------------
w_s1= 0.2*pi; w_p1= 0.35*pi; 
w_p2= 0.65*pi; w_s2= 0.8*pi;
transition_width= min((w_p1- w_s1),(w_s2 -w_p2)); A_s= 60;
M_order= ceil(11*pi/transition_width)+1;
n_sequence=[0:1:M_order-1];
w_c1= (w_s1+w_p1)/2;w_c2= (w_s2+w_p2)/2;
h_ideal= ideal_lp(w_c2,M_order)- ideal_lp(w_c1,M_order);
window_blackman=(blackman(M_order))';
h_actual=h_ideal.*window_blackman;
[db_response,mag_response,pha_response,grd_response,w_response]= freqz_m(h_actual,[1]);
delta_w_response = 2*pi/1000;
ripple_passband=-min(db_response(w_p1/delta_w_response+1:1:w_p2/delta_w_response));
atentuation_stopband=-round(max(db_response(w_s2/delta_w_response+1:1:501)))
subplot(2,2,1);
stem(n_sequence,h_ideal,'black'); title('Ideal Impulse Response');xlabel('n'); ylabel('h_d(n)');axis([0 M_order -0.4 0.5]);
subplot(2,2,2);
stem(n_sequence,window_blackman,'black');title('Blackman Window');xlabel('n'); ylabel('w_(n)');axis([0 M_order 0 1.1]);
subplot(2,2,3); stem(n_sequence,h_actual,'black');title('Actual Impulse Response');
xlabel('n'); ylabel('h_(n)');axis([0 M_order -0.4 0.5]);
subplot(2,2,4);plot(w_response/pi,db_response,'black');title('Magnituude Response - dB');grid;
xlabel('frequency - pi units'); ylabel('Decibels');axis([0 1 -150 10]);