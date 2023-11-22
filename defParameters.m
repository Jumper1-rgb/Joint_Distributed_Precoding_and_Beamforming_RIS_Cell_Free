function [Iter, L, Nt, APpwr, K, Nr, UEpwr, R, M, sigma2, Hd_lk, h_rk, g_lr, u_k, F, Theta] = defParameters()
Iter       = 30; % 最大迭代次数
% AP参数
L          = 5; % AP数量
Nt         = 2; % 每个AP的天线数
APpwr      = 1e-3; % AP的最大传输功率，W

% UE参数
K          = 4; % UE数量
Nr         = 2; % 每个UE的天线数
UEpwr      = 1e-4; % UE的最大传输功率，W

% RIS参数
R          = 2; % RIS数量
M          = 64; % 每个RIS的单元数

% 噪声参数
sigma2     = 1e-10; % 噪声方差

%% 生成AP、RIS和用户的位置
[distAP2RIS, distAP2User, distRIS2User] = positionGenerate(L, K, R);

%% 生成信道
[Hd_lk, h_rk, g_lr] = channelGenerate(L, R, K, M, Nt, Nr, distAP2RIS, distAP2User, distRIS2User); 

%% 初始化优化变量(u, F, Theta) 
[u_k, F, Theta] = initOptVariable(L, R, K, M, Nt, Nr, APpwr, UEpwr);
end