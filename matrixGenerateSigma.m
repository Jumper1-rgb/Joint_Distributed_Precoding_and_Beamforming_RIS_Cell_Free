function Sigma = matrixGenerateSigma(L, R, K, M, F, d_lk)
Sigma = zeros(M*R,M*R);
sumTemp = zeros(M*R,1);
for k = 1:K
    for i = 1:K
        for l = 1:L
            sumTemp = sumTemp + d_lk(:,:,l,k)*F.f_lk(:,l,i);
        end
        Sigma = Sigma + sumTemp*sumTemp';
        sumTemp = zeros(M*R,1);
    end
end
end