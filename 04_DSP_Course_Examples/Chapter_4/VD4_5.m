M=45; As=60;n=[0:1:M-1];
beta=0.1102*(As-8.7)
w_kai=(kaiser(M,beta))';wc1=pi/3;wc2=2*pi/3;
hd= ideal_lp(wc1,M)+ideal_lp(pi,M)-ideal_lp(wc2,M);
h=hd.*w_kai;[db,mag,pha,grd,w]= freqz_m(h,[1]);
subplot(2,2,1);
stem(n,hd); title('Ideal Impulse Response');xlabel('n'); ylabel('h_d(n)');axis([-1 M-0.2 -0.2 0.8]);
subplot(2,2,2);
stem(n,w_kai);title('Kaiser Window');xlabel('n'); ylabel('w(n)');axis([-1 M 0 1.1]);
subplot(2,2,3); stem(n,h);title('Actual Impulse Response');
xlabel('n'); ylabel('h(n)');axis([-1 M -0.2 0.8]);
subplot(2,2,4);plot(w/pi,db);title('Magnituude Response - dB');grid;
xlabel('frequency in pi units'); ylabel('Decibels');axis([0 1 -80 10]);