function f_lk = matCovertf_k2f_lk(L, K, Nt, f_k)
f_lk = zeros(Nt, L, K);
for k = 1:K
    for l = 1:L
        f_lk(:,l,k) = f_k((l-1)*Nt+1:l*Nt,k);
    end
end
end