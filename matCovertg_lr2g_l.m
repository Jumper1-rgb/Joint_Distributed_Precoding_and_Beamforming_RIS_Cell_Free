function g_l = matCovertg_lr2g_l(L, R, M, Nt, g_lr)
% g_lr - 矩阵大小(M,Nt,L,R)
g_l = zeros(M*R,Nt,L);
for l = 1:L
    for r = 1:R
        g_l((r-1)*M+1:r*M,:,l) = g_lr(:,:,l,r);
    end
end
end