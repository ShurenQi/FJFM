function [output] = getPZM_RadialPoly(order,repetition,rho)
% obtain the order and repetition
n = order;
m = repetition;
output = zeros(size(rho));      % initilization

% compute the radial polynomial
for s = 0:(n-abs(m))
    c = (-1)^s*factorial(2*n+1-s) / ...
        (factorial(s)*factorial(n+abs(m)-s+1)*factorial(n-abs(m)-s));
    output = output + c * rho .^ (n-s);
end
output=output*sqrt((n+1)/pi);
end % end getRadialPoly method