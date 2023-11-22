function H_lk = channelGenerateDL(L, K, Nt, Nr, Hd_lk, h_rk, g_lr, Theta)
H_lk.H_lk = zeros(Nt, Nr, L, K);
for l = 1:L
    for k = 1:K
        H_lk.H_lk(:,:,l,k) = (Hd_lk(:,:,l,k)' + h_rk.h_k(:,:,k)'*Theta.Theta*g_lr.g_l(:,:,l))';
    end
end
% 按L合并矩阵
H_lk.H_k = matCovertH_lk2H_k(L, K, Nt, Nr, H_lk.H_lk);
end