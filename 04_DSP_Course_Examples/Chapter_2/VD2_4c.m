n=[0:50];x=cos(0.04*pi*n)+0.2*randn(size(n));
figure;subplot(1,2,1);stem(n,x);title('Sequence in Problem 2.1c')
xlable('n');ylable('x(n)');