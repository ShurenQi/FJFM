function [output] = getRP_Direct(order,rho,P,Q,alpha)
% obtain the order and repetition
n = order;
output = zeros(size(rho));      % initilization

% compute the radial polynomial
for k = 0:n
    c = ((-1)^k)*gamma(P+n+k)/(factorial(n-k)*factorial(k)*gamma(Q+k));
    output = output + c * (rho.^(alpha*(k)));
end
output=output.*(factorial(n)*gamma(Q)/gamma(P+n)).*sqrt(alpha*((1-rho.^alpha).^(P-Q)).*(rho.^(alpha*Q-1))./(rho*(factorial(order)*gamma(Q)*gamma(Q)*gamma(P-Q+order+1)/(gamma(Q+order)*gamma(P+order)*(P+2*order)))));
end % end getRadialPoly method