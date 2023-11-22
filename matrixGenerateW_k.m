function W_k = matrixGenerateW_k(K, Nr, H_lk, F)
W_k = zeros(Nr,Nr,K);
for k = 1:K
    for i = 1:K
        W_k(:,:,k) = W_k(:,:,k) + (H_lk.H_k(:,:,k)'*F.f_k(:,i))*(H_lk.H_k(:,:,k)'*F.f_k(:,i))';
    end
end
end