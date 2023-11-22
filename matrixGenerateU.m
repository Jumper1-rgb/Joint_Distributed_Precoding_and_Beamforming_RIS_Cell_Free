function U = matrixGenerateU(L, R, K, M, F, c, d_lk)
uTemp1 = zeros(M*R,1);
uTemp2 = zeros(M*R,1);
sumTemp1 = zeros(M*R,1);
sumTemp2 = 0;
for k = 1:K
    for i = 1:K
        for l = 1:L
            sumTemp1 = sumTemp1 + d_lk(:,:,l,k)*F.f_lk(:,l,k);
            sumTemp2 = sumTemp2 + c.cd_lk(:,l,k)'*F.f_lk(:,l,k);
        end
        uTemp1 = uTemp1 + sumTemp1*sumTemp2';
        sumTemp1 = zeros(M*R,1);
        sumTemp2 = 0;
    end
end

for k = 1:K
    for l = 1:L
        uTemp2 = uTemp2 + d_lk(:,:,l,k)*F.f_lk(:,l,k);
    end
end

U = uTemp1 - uTemp2;
end