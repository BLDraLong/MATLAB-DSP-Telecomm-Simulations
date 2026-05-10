function [y,n] = gap_tinhieu(x,n)
%GAP_TINNHIEU Summary of this function goes here
%   Detailed explanation goes here
%implement y(n)=x(-n)
%[y,n]= sigfold(x,n)
y=fliplr(x);n= -fliplr(n);
end

