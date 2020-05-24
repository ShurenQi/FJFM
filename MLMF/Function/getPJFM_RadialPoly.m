function [output] = getPJFM_RadialPoly(order,rho)
% obtain the order and repetition
n = order;
output = zeros(size(rho));      % initilization

% compute the radial polynomial
for k = 0:n
    c = ((-1)^(n+k))*factorial(n+k+3) / ...
        (factorial(n-k)*factorial(k)*factorial(k+2));
    output = output + c * rho .^ (k);
end
output=output.*sqrt((2*n+4)*(rho-rho.^2)/((n+3)*(n+1)))/(2*pi);
end % end getRadialPoly method