n=-10:1:10;temp=0;
for k= -10:1:10
    temp=temp+exp(-1*abs(k))*ham_xung(k,-10,10);
end
xn = temp;stem(n,xn)