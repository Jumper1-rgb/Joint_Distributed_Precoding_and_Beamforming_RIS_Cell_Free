function h = channelGenerateh(M, Nr, distRIS2User)
scaleRayleighB = 1;
pathLossC0 = 1e-3;
kappaRIS2User = 2.8;
antennaGain = 2; % 3dBi 天线增益 
h = raylrnd(scaleRayleighB, M, Nr); % 标Rayleigh分布
h = h.*exp(1i*2*pi*rand(M,Nr)); % 复Rayleigh分布
pathLoss = sqrt(antennaGain*pathLossC0*distRIS2User^(-kappaRIS2User));
h = pathLoss*h;
end