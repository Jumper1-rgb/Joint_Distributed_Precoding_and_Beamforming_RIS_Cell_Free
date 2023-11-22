function f_k = matCovertflk2fk(L, K, Nt, f_lk)
f_k = zeros(L*Nt,K);
for k = 1:K
   for l = 1:L
       f_k((l-1)*Nt+1:l*Nt,k) = f_lk(:,l,k);
   end
end
end