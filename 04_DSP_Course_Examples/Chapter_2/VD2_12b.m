x = ham_bac(0, -20, 120); 
s = filter(b, a, x);
subplot(2, 1, 2); 
stem(n, s);
title('Step Response'); xlabel('n'); ylabel('s(n)');
sum(abs(h))