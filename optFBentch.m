function F = optFBentch(L, K, Nt, APpwr, H_lk, u_k)
% 每个AP的功率约束矩阵，用于CVX表达式
P_l = zeros(Nt, L*Nt, L);
for l = 1:L
    P_l(:,(l-1)*Nt+1:l*Nt,l) = eye(Nt);
end
% 生成辅助矩阵B
B = matrixGenerateB(L, K, Nt, H_lk, u_k); % 矩阵大小 - B.b_lk:(Nt,L,K); B.b_k:(L*Nt,K); B.B:(L*Nt,K)

% 生成辅助矩阵Lambda
Lambda = matrixGenerateLambda(L, K, Nt, B); % 矩阵大小 - (L*Nt,L*Nt)

% 利用CVX优化变量F
cvx_begin quiet
variable F_CVX(L*Nt,K) complex
minimize (square_pos(norm(B.B'*F_CVX, 'fro'))- 2*trace(real(B.B'*F_CVX)))
% minimize (trace(F_CVX'*Lambda*F_CVX)- 2*trace(real(B.B'*F_CVX)))
subject to
for l = 1:L
   norm(P_l(:,:,l)*F_CVX,'fro') <= sqrt(APpwr);
end
cvx_end

% 拆分F_CVX矩阵
F.F = F_CVX;
F.f_k = F_CVX;
F.f_lk = matCovertf_k2f_lk(L, K, Nt, F.f_k);
end