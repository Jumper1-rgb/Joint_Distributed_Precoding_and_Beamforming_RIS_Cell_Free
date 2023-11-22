function [u_k, F, Theta, sumRate] = optAlgorithmDistributed(L, R, K, M, Nt, Nr, APpwr, sigma2, u_k, Hd_lk, h_rk, g_lr, F, Theta, Iter)
sumRate = zeros(Iter,1);
alpha = [0.5, 0.2, 0.2, 0.1, 0.1, 0.18, ...
    0.15, 0.12, 0.1, 0.1, 0.08, 0.07, ...
    0.05, 0.02*ones(1,10), 0.01*ones(1,10), 0.005*ones(1,100)];

for iter = 1:Iter
% 生成下行信道
H_lk = channelGenerateDL(L, K, Nt, Nr, Hd_lk, h_rk, g_lr, Theta);

% 计算和速率
sumRate(iter) = calSumRate(K, sigma2, u_k, H_lk, F);

% 优化组合向量u_k
u_k = optu_kBentch(K, Nr, sigma2, H_lk, F); % 矩阵大小 - u_k:(Nr,K)

% 记录上次预编码矩阵
F_before = F;

% 优化预编码矩阵F
F = optFDistributed(L, K, Nt, H_lk, u_k, F, APpwr); % 矩阵大小 - F.F:(L*Nt,K)

% 预编码矩阵的迭代
F.f_lk = (1-alpha(iter))*F_before.f_lk + alpha(iter)*(F.f_lk);

% F矩阵转换
F.f_k = matCovertflk2fk(L, K, Nt, F.f_lk);
F.F = F.f_k; % 矩阵大小 - (L*Nt,K)

% 优化RIS相移矩阵Theta
Theta = optThetaBentch(L, R, K, M, Nt, u_k, Hd_lk, h_rk, g_lr, F); % 矩阵大小 - Theta.Theta:(MR,MR)
end
end