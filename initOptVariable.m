function [u_k, F, Theta] = initOptVariable(L, R, K, M, Nt, Nr, APpwr, UEpwr)
% 初始化u_k向量
u_k = sqrt(UEpwr/K/Nr)*ones(Nr, K);

% 初始化F矩阵
F.f_lk = sqrt(APpwr/K/Nt)*ones(Nt, L, K);
F.f_k = matCovertflk2fk(L, K, Nt, F.f_lk);
F.F = F.f_k; % 矩阵大小 - (L*Nt,K)

% 初始化Theta矩阵
Theta.Theta_r = zeros(M, M, R);
for r = 1:R
   Theta.Theta_r(:,:,r) = diag(exp(1i*2*pi*(rand(M,1)))); 
end
Theta.Theta = matCovertTheta_r2Theta(R, M, Theta.Theta_r); % 矩阵大小 - (MR,MR)
Theta.Phi = ones(1,M*R)*Theta.Theta; % 矩阵大小 - (1,MR)
end