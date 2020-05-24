function [output] = getRP_Recursive(order,rho,P,Q,alpha)
% obtain the order
n = order;

% PN
if n>=2
    P0=(gamma(P)/gamma(Q))*ones(size(rho));
    P1=(gamma(P+1)/gamma(Q))*(1-((P+1)/Q)*(rho.^alpha));
    PN1=P1;PN2=P0;
    for k = 2:n
        L1=-((2*k+P-1)*(2*k+P-2))/(k*(Q+k-1));
        L2=(P+2*k-2)+(((k-1)*(Q+k-2)*L1)/(P+2*k-3));
        L3=((P+2*k-4)*(P+2*k-3)/2)+((Q+k-3)*(k-2)*L1/2)-((P+2*k-4)*L2);
        PN=(L1*(rho.^alpha)+L2).*PN1+L3.*PN2;
        PN2=PN1;
        PN1=PN;
    end
elseif n==1
    PN=(gamma(P+1)/gamma(Q))*(1-((P+1)/Q)*(rho.^alpha));
elseif n==0
    PN=(gamma(P)/gamma(Q))*ones(size(rho));
end

%AN
if n>=1
    A0=sqrt(gamma(Q)/(gamma(P)*gamma(P-Q+1)));
    AN1=A0;
    for k = 1:n
        AN=sqrt(k*(Q+k-1)/((P+k-1)*(P-Q+k)))*AN1;
        AN1=AN;
    end
elseif n==0
    AN=sqrt(gamma(Q)/(gamma(P)*gamma(P-Q+1)));
end

output=sqrt((P+2*n)*alpha*((1-rho.^alpha).^(P-Q)).*(rho.^(alpha*Q-1))./rho)*AN.*PN;

end % end getRadialPoly method