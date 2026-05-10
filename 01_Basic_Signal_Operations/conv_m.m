function [y,ny]=conv_m(x,nx,h,nh)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
nyb= nx(1)+nh(1);nye=nx(length(x))+nh(length(h));
ny= [nyb:nye];y=conv(x,h);
end

