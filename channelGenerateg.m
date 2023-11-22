function g = channelGenerateg(M, Nt, distAP2RIS)
pathLossC0 = 1e-3;
kappaAP2RIS = 2.2;
g = ones(M, Nt);
antennaGain = 2; % 3dBi 天线增益 
pathLoss = sqrt(antennaGain*pathLossC0*distAP2RIS^(-kappaAP2RIS));
g = pathLoss*g;
end