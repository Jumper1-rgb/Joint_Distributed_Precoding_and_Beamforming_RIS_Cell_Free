function B = matrixGenerateB(L, K, Nt, H_lk, u_k)
B.b_lk = zeros(Nt, L, K);
B.b_k = zeros(L*Nt, K);
for l = 1:L
    for k = 1:K
        B.b_lk(:,l,k) = H_lk.H_lk(:,:,l,k)*u_k(:,k);
        B.b_k((l-1)*Nt+1:l*Nt,k) = B.b_lk(:,l,k);
    end
end
B.B = B.b_k;
end