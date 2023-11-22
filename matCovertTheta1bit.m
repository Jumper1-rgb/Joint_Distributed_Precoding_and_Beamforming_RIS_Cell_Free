function Theta = matCovertTheta1bit(R, M, Theta)
angleList = [0, pi];
angleTheta = angle(Theta.Phi) + pi; % [0, 2*pi]之间
for i = 1:length(angleTheta)
    [~, idx] = min(abs(angleTheta(i)-angleList));
    angleTheta(i) = angleList(idx);
end
Theta.Phi = exp(1i*angleTheta);
Theta.Theta = diag(Theta.Phi);
Theta.Theta_r = matCovertTheta2Theta_r(R, M, Theta.Theta);
end