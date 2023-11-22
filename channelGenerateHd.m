function Hd = channelGenerateHd(Nt, Nr, distAP2User)
scaleRayleighB = 1;
pathLossC0 = 1e-3;
kappaAP2RIS = 3.5;
Hd = raylrnd(scaleRayleighB, Nt, Nr); % 标Rayleigh分布
Hd = Hd.*exp(1i*2*pi*rand(Nt,Nr)); % 复Rayleigh分布
pathLoss = sqrt(pathLossC0*distAP2User^(-kappaAP2RIS));
Hd = pathLoss*Hd;
end