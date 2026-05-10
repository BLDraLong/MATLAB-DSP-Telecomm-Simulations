%% HÀM H? TR?: Đáp ?ng xung c?a b? l?c thông th?p l? tư?ng
function h_lp = ideal_lp(wc, M)
    alpha = (M-1)/2;
    n = 0:M-1;
    h_lp = wc/pi * sinc(wc*(n-alpha)/pi);
end

