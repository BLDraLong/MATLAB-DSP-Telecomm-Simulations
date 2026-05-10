a=[1 -0.5] ;b=1;xn=[1 2 3]
yn=filter(b,a,xn)
n=1:100;
h=impz(b,a,n)