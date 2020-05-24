function [output] = getCHFM_RadialPoly(order,rho)
% obtain the order and repetition
n = order;
output = zeros(size(rho));      % initilization

% compute the radial polynomial
for s = 0:floor(n/2)
    c = ((-1)^s)*factorial(n-s) / ...
        (factorial(s)*factorial(n-2*s));
    output = output + c * (4*rho-2) .^ (n-2*s);
end
output=output.*((64*(1-rho)./(pi*pi*rho)).^(1/4))*sqrt(1/(2*pi));
end % end getRadialPoly method