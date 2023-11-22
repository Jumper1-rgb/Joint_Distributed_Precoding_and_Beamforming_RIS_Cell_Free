function sumRate = calSumRate(K, sigma2, u_k, H_lk, F)
SINR_k = zeros(K,1);
for k = 1:K
    sumPwr_K = 0;
    for i = 1:K
        sumPwr_K = sumPwr_K + norm(u_k(:,k)'*H_lk.H_k(:,:,k)'*F.f_k(:,i))^2;
    end
    pwr_k = norm(u_k(:,k)'*H_lk.H_k(:,:,k)'*F.f_k(:,k))^2;
    SINR_k(k) = pwr_k/(sumPwr_K - pwr_k + norm(u_k(:,k))^2*sigma2);
end
sumRate = sum(log2(1+SINR_k));
end