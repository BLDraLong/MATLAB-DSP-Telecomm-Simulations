n=[0:20];x1=n.*(ham_bac(0,0,20)-ham_bac(10,0,20));
x2= 10*exp(-0.3*(n-10)).*(ham_bac(10,0,20)-ham_bac(20,0,20));
x=x1+x2;
subplot(1,2,2);stem(n,x);title('Sequence in Problem 2.1b')
xlable('n');ylable('x(n)');