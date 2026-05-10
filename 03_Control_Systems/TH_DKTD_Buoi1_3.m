num=[1];
den=conv([1 3],[1 8 20]);
G = tf(num,den);
rlocus(G); grid on;

