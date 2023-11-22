function u_k = optu_kBentch(K, Nr, sigma2, H_lk, F)
u_k = zeros(Nr,K);
% 处理用于优化u_k的矩阵W_k
W_k = matrixGenerateW_k(K, Nr, H_lk, F); % 矩阵大小 - (Nr,Nr,K)
for k = 1:K
   u_k(:,k) = (W_k(:,:,k)+sigma2*eye(Nr))^(-1)*H_lk.H_k(:,:,k)'*F.f_k(:,k);
end
end