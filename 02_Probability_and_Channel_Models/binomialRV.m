function X = binomialRV(n,p,L)

X = zeros(1,L);

for i = 1:L
    X(i) = sum(bernoulliRV(n,p));
end

end
