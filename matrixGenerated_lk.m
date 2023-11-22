function d_lk = matrixGenerated_lk(L, R, K, M, Nt, g_lr, c)
d_lk = zeros(M*R,Nt,L,K);
for l = 1:L
    for k = 1:K
        d_lk(:,:,l,k) = diag(c.c_k(:,k)')*g_lr.g_l(:,:,l);
    end
end
end