function F = optFLMMSE(L, K, Nt, H_lk, u_k, F, APpwr)
F.f_lk = zeros(Nt, L, K);
% 生成辅助矩阵B
B = matrixGenerateB(L, K, Nt, H_lk, u_k); % 矩阵大小 - B.b_lk:(Nt,L,K); B.b_k:(L*Nt,K); B.B:(L*Nt,K)

% 生成辅助矩阵Lambda
Lambda = matrixGenerateLambda(L, K, Nt, B); % 矩阵大小 - (L*Nt,L*Nt)

% 二分法查找lambda用于满足功率约束

for l = 1:L
    errth = 1e-6;
    errVal = 1;
    lower = 1e-6;
    upper = 1e6;
    while (abs(errVal)>errth) && (upper >= errth)
        lambda = (lower+upper)/2;
        for k = 1:K
            F.f_lk(:,l,k) = (Lambda((l-1)*Nt+1:l*Nt,(l-1)*Nt+1:l*Nt)+lambda*eye(Nt))^(-1)*(B.b_lk(:,l,k));
        end
        errVal = norm(reshape(F.f_lk(:,l,:),Nt,K))^2 - APpwr;
        if errVal > 0
            lower = lambda;
        else
            upper = lambda;
        end
    end
end

% F矩阵转换
F.f_k = matCovertflk2fk(L, K, Nt, F.f_lk);
F.F = F.f_k; % 矩阵大小 - (L*Nt,K)
end