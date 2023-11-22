function Lambda = matrixGenerateLambda(L, K, Nt, B)
Lambda = zeros(L*Nt, L*Nt);
for k = 1:K
   Lambda = Lambda + B.b_k(:,k)*B.b_k(:,k)'; 
end
end