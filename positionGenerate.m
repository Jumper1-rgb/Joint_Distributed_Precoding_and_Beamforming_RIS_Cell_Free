function [distAP2RIS, distAP2User, distRIS2User] = positionGenerate(L, K, R)
DIST = 65; % 用于生成用户的中心距离，m
distAPHeight = 3; % AP高度，m
distRISHeight = 6; % RIS高度，m
distUserHeight = 1.5; % UE高度，m
positionUserR = 1; % 生成UE的半径
distAP2RIS = zeros(L,R);
distAP2User = zeros(L,K);
distRIS2User = zeros(R,K);
positionAP = zeros(L,2);
positionRIS = zeros(R,2);
positionUser = zeros(K,2);

% 生成AP位置
for l = 1:L
    positionAP(l,:) = [(l-1)*40 -50];
end

% 生成RIS位置
positionRIS(1,:) = [60 10];
positionRIS(2,:) = [100 10];

% 生成UE位置
positionUserRandAngle = 2*pi*rand(K,1);
positionUserRandr = rand(K,1);
for k = 1:K
   positionUser(k,:) = [DIST+positionUserR*positionUserRandAngle(k)*cos(positionUserRandr(k)) ,...
       positionUserR*positionUserRandAngle(k)*sin(positionUserRandr(k))];
end

% 计算AP到RIS的距离
for l = 1:L
    for r = 1:R
        distAP2RIS(l,r) = sqrt(sum((positionAP(l,:) - positionRIS(r,:)).^2) + (distAPHeight - distRISHeight)^2);
    end
end

% 计算AP到UE的距离
for l = 1:L
    for k = 1:K
        distAP2User(l,k) = sqrt(sum((positionAP(l,:) - positionUser(k,:)).^2) + (distAPHeight - distUserHeight)^2);
    end
end

% 计算RIS到UE的距离
for r = 1:R
    for k = 1:K
        distRIS2User(r,k) = sqrt(sum((positionRIS(r,:) - positionUser(k,:)).^2) + (distRISHeight - distUserHeight)^2);
    end
end

end