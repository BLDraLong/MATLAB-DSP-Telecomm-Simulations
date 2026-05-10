[x21,n21]=gap_tinhieu(x,n);[x21,n21]=dichchuyen_tinhieu(x21,n21,3);
[x22,n22]=dichchuyen_tinhieu(x,n,2);[x22,n22]=nhan_2tinhieu(x,n,x22,n22);
[x2,n2]=cong_2tinhieu(x21,n21,x22,n22);
subplot(2,1,2);stem(n2,x2);title('Sequence in Problem 2.2b');
xlable('n');ylable('x2(n)');