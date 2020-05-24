function [output] = getFCHFM_RadialPoly(order,rho,alpha)
% obtain the order and repetition
n = order;
output = zeros(size(rho));      % initilization
% compute the radial polynomial
for s = 0:floor(n/2)
    c = ((-1)^s)*factorial(n-s) / ...
        (factorial(s)*factorial(n-2*s));
    output = output + c * ((4*(rho.^alpha)-2).^ (n-2*s)).*sqrt(alpha).*rho.^((alpha-1));
end
output=output.*(((1-(rho.^alpha))./(rho.^alpha)).^(1/4));
end % end getRadialPoly method