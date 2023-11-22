clear, clc, tic
%% 定义参数并生成信道
% [Iter, L, Nt, APpwr, K, Nr, UEpwr, R, M, sigma2, Hd_lk, h_rk, g_lr, u_k, F, Theta] = defParameters();
% load('channelParams')
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

%% 提出的优化算法
% 集中式算法Bentchmark
[~, ~, ~, sumRateBentch] =  optAlgorithmBentch(L, R, K, M, Nt, Nr, APpwr, sigma2, u_k, Hd_lk, h_rk, g_lr, F, Theta, Iter);

% 分布式算法
[~, ~, ~, sumRateDistributed] =  optAlgorithmDistributed(L, R, K, M, Nt, Nr, APpwr, sigma2, u_k, Hd_lk, h_rk, g_lr, F, Theta, Iter);

% L-MMSE算法
[~, ~, ~, sumRateLMMSE] =  optAlgorithmLMMSE(L, R, K, M, Nt, Nr, APpwr, sigma2, u_k, Hd_lk, h_rk, g_lr, F, Theta, Iter);

% RIS采用随机矩阵
[~, ~, ~, sumRateRandTheta] =  optAlgorithmRandTheta(L, R, K, M, Nt, Nr, APpwr, sigma2, u_k, Hd_lk, h_rk, g_lr, F, Theta, Iter);

% 没有RIS的情况
[~, ~, ~, sumRateNoRIS] =  optAlgorithmNoRIS(L, R, K, M, Nt, Nr, APpwr, sigma2, u_k, Hd_lk, h_rk, g_lr, F, Theta, Iter);

% 1 bit-RIS相移矩阵
% [~, ~, ~, sumRate1bitTheta] =  optAlgorithm1bitTheta(L, R, K, M, Nt, Nr, APpwr, sigma2, u_k, Hd_lk, h_rk, g_lr, F, Theta, Iter);

% 2 bit-RIS相移矩阵
% [~, ~, ~, sumRate2bitTheta] =  optAlgorithm2bitTheta(L, R, K, M, Nt, Nr, APpwr, sigma2, u_k, Hd_lk, h_rk, g_lr, F, Theta, Iter);

%% Plot
figure, hold on, grid on
plot(sumRateBentch)
plot(sumRateDistributed)
plot(sumRateLMMSE)
plot(sumRateRandTheta)
plot(sumRateNoRIS)
% plot(sumRate1bitTheta)
% plot(sumRate2bitTheta)
toc