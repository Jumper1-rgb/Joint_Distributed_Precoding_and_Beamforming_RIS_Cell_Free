function [Hd_lk, h_rk, g_lr] = channelGenerate(L, R, K, M, Nt, Nr, distAP2RIS, distAP2User, distRIS2User)
% Hd_lk - AP到UE的直接链路
% h_rk - RIS到UE的链路
% g_lr - AP到RIS的链路
Hd_lk = zeros(Nt, Nr, L, K); % AP到UE的直接链路
h_rk.h_rk = zeros(M, Nr, R, K); % RIS到UE的链路
g_lr.g_lr = zeros(M, Nt, L, R); % AP到RIS的链路

% 生成Hd_lk信道
for l = 1:L
    for k = 1:K
        Hd_lk(:,:,l,k) = channelGenerateHd(Nt, Nr, distAP2User(l,k));
    end
end

% 生成h_rk信道
for r = 1:R
    for k = 1:K
        h_rk.h_rk(:,:,r,k) = channelGenerateh(M, Nr, distRIS2User(r,k));
    end
end

% 生成g_lr信道
for l = 1:L
    for r = 1:R
        g_lr.g_lr(:,:,l,r) = channelGenerateg(M, Nt, distAP2RIS(l,r));
    end
end

% 按R合并矩阵
h_rk.h_k = matCoverth_rk2h_k(R, K, M, Nr, h_rk.h_rk); % 矩阵大小 - (MR,Nr,K)
g_lr.g_l = matCovertg_lr2g_l(L, R, M, Nt, g_lr.g_lr); % 矩阵大小 - (MR,Nt,L)
end