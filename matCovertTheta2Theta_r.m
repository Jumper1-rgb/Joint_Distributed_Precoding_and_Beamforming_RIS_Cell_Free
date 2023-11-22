function Theta_r = matCovertTheta2Theta_r(R, M, Theta)
Theta_r = zeros(M,M,R);
for r = 1:R
    Theta_r(:,:,r)= Theta((r-1)*M+1:r*M,(r-1)*M+1:r*M);  
end
end