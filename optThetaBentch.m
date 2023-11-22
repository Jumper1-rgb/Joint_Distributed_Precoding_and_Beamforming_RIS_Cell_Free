function Theta = optThetaBentch(L, R, K, M, Nt, u_k, Hd_lk, h_rk, g_lr, F)
% 生成辅助矩阵c，矩阵大小 - c.cd_lk：(Nt,L,K); c.c_k：(MR,K)
c = matrixGeneratec(L, R, K, M, Nt, u_k, Hd_lk, h_rk);

% 生成辅助矩阵d_lk，矩阵大小 - d_lk: (MR,Nt,L,K)
d_lk = matrixGenerated_lk(L, R, K, M, Nt, g_lr, c);

% 生成辅助矩阵Sigma，矩阵大小 - Sigma：(MR,MR)
Sigma = matrixGenerateSigma(L, R, K, M, F, d_lk);

% 生成辅助矩阵U，矩阵大小 - U：(MR,1)
U = matrixGenerateU(L, R, K, M, F, c, d_lk);

% 利用CVX优化变量Phi = ones(1,M*R)*Theta
cvx_begin quiet
%     cvx_precision low
    variable Phi(1,M*R) complex
    minimize (Phi*Sigma*Phi'+2*real(Phi*U))
    subject to
    for i = 1:M*R
       abs(Phi(i)) <= 1;
    end
cvx_end

% 导出Theta矩阵
Theta.Phi = Phi; % 矩阵大小 - (1,MR)
Theta.Theta = diag(Phi); % 矩阵大小 - (MR,MR)
Theta.Theta_r = matCovertTheta2Theta_r(R, M, Theta.Theta); % 矩阵大小 - (M,M,R)
end