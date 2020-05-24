function [output] = getOFMM_RadialPoly(order,rho)
% obtain the order and repetition
n = order;
output = zeros(size(rho));      % initilization

% compute the radial polynomial
for s = 0:n
    c = ((-1)^(n+s))*factorial(n+s+1) / ...
        (factorial(n-s)*factorial(s)*factorial(s+1));
    output = output + c * (rho .^ (s));
end
output=output*sqrt((n+1)/pi);
end % end getRadialPoly method