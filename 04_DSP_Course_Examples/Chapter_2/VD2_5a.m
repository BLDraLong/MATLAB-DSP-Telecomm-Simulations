clc; clear all; close all;
n=-2:10;x=[1:7,6:-1:1];
[x11,n11]=dichchuyen_tinhieu(x,n,5);[x12,n12] = dichchuyen_tinhieu(x,n,-4);
[x1,n1]=cong_2tinhieu(2*x11,n11,-3*x12,n12);
subplot(2,1,1); stem(n1,x1);title('Sequence in Problem 2.2a')
xlable('n');ylable('x1(n)');