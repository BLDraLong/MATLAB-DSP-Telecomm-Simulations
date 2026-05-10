%% =========================================================
%                     HAM PHU
% =========================================================

function h = nakagami_fading(N, m)
    % Tạo kênh fading Nakagami-m
    % Sử dụng phương pháp chi-square distribution
    r2 = gamrnd(m, 1/m, [N, 1]); % |h|^2 tuân theo Gamma distribution
    phi = 2*pi*rand(N, 1);       % Phase ngẫu nhiên
    h = sqrt(r2) .* exp(1i*phi);
end