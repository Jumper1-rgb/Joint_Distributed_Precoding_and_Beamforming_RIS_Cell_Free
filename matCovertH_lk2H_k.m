function H_k = matCovertH_lk2H_k(L, K, Nt, Nr, H_lk)
H_k = zeros(L*Nt,Nr,K);
for l = 1:L
    for k = 1:K
        H_k((l-1)*Nt+1:l*Nt,:,k) = H_lk(:,:,l,k);
    end
end
end