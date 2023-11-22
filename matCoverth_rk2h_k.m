function h_k = matCoverth_rk2h_k(R, K, M, Nr, h_rk)
% h_rk - 矩阵大小 (M,Nr,R,K)
h_k = zeros(M*R,Nr,K);
for r = 1:R
    for k = 1:K
        h_k((r-1)*M+1:r*M,:,k) = h_rk(:,:,r,k); 
    end
end
end