%d.)x~(n)={1,2,3,4,5,6,7,6,5,4,3,2,1};?10?n?9.
n=[-10:9];x=[5,4,3,2,1];
xtilde=x'*ones(1,4);xtilde=(xtilde(:))';
subplot(1,2,2); stem(n,xtilde);title('Sequence in Problem 2.1d')
xlable('n');ylable('x(n)');