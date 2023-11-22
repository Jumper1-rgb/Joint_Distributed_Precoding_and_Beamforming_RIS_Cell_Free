function [u_k, F, Theta, sumRate] = optAlgorithmRandTheta(L, R, K, M, Nt, Nr, APpwr, sigma2, u_k, Hd_lk, h_rk, g_lr, F, Theta, Iter)
sumRate = zeros(Iter,1);

for iter = 1:Iter
% 生成下行信道
H_lk = channelGenerateDL(L, K, Nt, Nr, Hd_lk, h_rk, g_lr, Theta);

% 计算和速率
sumRate(iter) = calSumRate(K, sigma2, u_k, H_lk, F);

% 优化组合向量u_k
u_k = optu_kBentch(K, Nr, sigma2, H_lk, F); % 矩阵大小 - u_k:(Nr,K)

% 优化预编码矩阵F
F = optFBentch(L, K, Nt, APpwr, H_lk, u_k); % 矩阵大小 - F.F:(L*Nt,K)

% 优化RIS相移矩阵Theta
% Theta = optThetaBentch(L, R, K, M, Nt, u_k, Hd_lk, h_rk, g_lr, F); % 矩阵大小 - Theta.Theta:(MR,MR)
end
end