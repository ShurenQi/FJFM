function [ output ] = FJFM_D(img,maxorder,P,Q,alpha)
[N, M]  = size(img);
x       = -1+1/M:2/M:1-1/M;
y       = 1-1/N:-2/N:-1+1/N;
[X,Y]   = meshgrid(x,y);
[th, r]  = cart2pol(X, Y);
pz=th<0;
theta =zeros(N,M);
theta(pz)     = th(pz) + 2*pi;
theta(~pz)     = th(~pz);
pz=r>1;
rho =zeros(N,M);
rho(pz)     = 0.5;
rho(~pz)     = r(~pz); 
output=zeros(maxorder+1,2*maxorder+1);
for order=0:1:maxorder
    R=getRP_Recursive(order,rho,P,Q,alpha);
%     R=getRP_Direct(order,rho,P,Q,alpha);
    for repetition=-maxorder:1:maxorder
        pupil =R.*exp(-1j*repetition * theta);
        Product = double(img) .* pupil;
        cnt = nnz(R)+1;
        output(order+1,repetition+maxorder+1)=sum(Product(:))*(4/cnt)*(1/(2*pi));
    end
end
end