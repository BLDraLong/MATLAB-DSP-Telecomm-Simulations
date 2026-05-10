clc; clear all; close all
b = [1]; a = [1, -1, 0.9];
n = [-20:120];
h = impz(b, a, n);
subplot(2, 1, 1);
stem(n, h);
title('Impulse Response'); xlabel('n'); ylabel('h(n)');