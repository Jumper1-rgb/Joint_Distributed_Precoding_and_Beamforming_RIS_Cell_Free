function Theta = matCovertTheta_r2Theta(R, M, Theta_r)
Theta = zeros(M*R, M*R);
for r = 1:R
   Theta((r-1)*M+1:r*M,(r-1)*M+1:r*M) = Theta_r(:,:,r); 
end
end