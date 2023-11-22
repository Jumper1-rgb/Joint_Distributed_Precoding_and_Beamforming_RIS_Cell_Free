function c = matrixGeneratec(L, R, K, M, Nt, u_k, Hd_lk, h_rk)
c.cd_lk = zeros(Nt,L,K);
c.c_k = zeros(M*R, K);
for l = 1:L
    for k = 1:K
        c.cd_lk(:,l,k) = Hd_lk(:,:,l,k)*u_k(:,k);
    end
end

for k = 1:K
    c.c_k(:,k) = h_rk.h_k(:,:,k)*u_k(:,k);
end

end