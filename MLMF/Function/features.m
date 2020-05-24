function [Z] = features(I,LE,BF)
Z= zeros(LE,1);
for i=1:1:LE
    temp = I.*BF{i};
    Z(i,1) = sum(temp(:));
end
Z=abs(Z);
% Z=(Z-min(Z))/(max(Z)-min(Z));
end
