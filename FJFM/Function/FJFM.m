function [I,It,L,DT,RT,P,Q ] =FJFM(I,K,P,Q,alpha)
%% PRE
[N, M]  = size(I);
x       = -1+1/M:2/M:1-1/M;
y       = 1-1/N:-2/N:-1+1/N;
[X,Y]   = meshgrid(x,y);
[~, r]  = cart2pol(X, Y);
I(r>1)=0;
%% DE
tic;
X=FJFM_D(I,K,P,Q,alpha);
DT=toc;
%% RE
tic;
Y=FJFM_R(I,X,K,P,Q,alpha);
RT=toc;
It=abs(Y);
L=(K+1)*(2*K+1);
end

