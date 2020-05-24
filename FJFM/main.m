%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code was developed by Shuren Qi 
% i@srqi.email
% All rights reserved.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
close all;
clear all;
clc; 
addpath(genpath(pwd));
%% INPUT
I=imread('lena512.tif');
I=imresize(I,[256 256]);
%% MODE
K = input('Please enter the maximum order K (K>=0): ');
disp('Parameter Setting: p-q>-1, q>0, alpha>0;');
disp('e.g.');
disp('- OFMM: p=2, q=2, alpha=1;');
disp('- CHFM: p=2, q=3/2, alpha=1;');
disp('- PJFM: p=4, q=3, alpha=1;');
p = input('p=');
q = input('q=');
alpha=input('alpha=');
%% COMPUTE
if K>=0 && p-q>-1 && q>0 && alpha>0
    [I,It,L,DT,RT ]=FJFM(I,K,p,q,alpha);
else
    disp('Error!');
    return;
end
%% OUTPUT
figure;
subplot(121);
imshow(uint8(abs(I)));
title('Original');
subplot(122);
imshow(uint8(abs(It)));
different_a = (abs(abs( double(abs(It))-double(I)))).^2;
different_b = (double(I)).^2;
MSRE = sum(different_a(:))/sum(different_b(:));
clc;
disp(['FJFM',':    p=',num2str(p),', q=',num2str(q),', alpha=',num2str(alpha),';']);
disp(table([K;L;DT;RT;MSRE],'RowNames',{'K';'L';'DT';'RT';'MSRE'},'VariableNames',{'Value'}));
title({'Reconstructed'; ['K=',num2str(K),'  L=',num2str(L),'  MSRE=',num2str(MSRE)]});
