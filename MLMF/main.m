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
%% METHOD
VARrange=0:0.05:0.3;
MD={'1.PZM[1988]';'2.OFMM[1994]';'3.CHFM[2002]';'4.PJFM[2004]';'5.PCET[2010]';'6.GPCET[2014]';'7.FOFMM[2016]';'8.FCHFM[2019]';'9.FJFM-MLMF[ours]'};for i=1:1:9, disp(MD{i}); end
MODE = input('Please select a mode (1 ~ 9): ');
K = input('Please enter the maximum order K (K>=0): ');
if  K<0 
        disp('Error!');
        return;
end
[BF,NoF,p,q,alpha]=getBF(MODE,128,128,K);
clc;
if MODE==6 || MODE==7 || MODE==8
    disp([MD{MODE},' (alpha=',num2str(alpha),')']);
elseif MODE==9
    disp([MD{MODE},' (p=',num2str(p),',q=',num2str(q),')']);
else
    disp(MD{MODE});
end  
disp(table([K;NoF],'RowNames',{'K';'NoF'},'VariableNames',{'Value'}));
disp('~~~~~~~~~~~~~~~~~~~~~~~~~~');
disp(['	VAR      ','   CCP(%)']);
flg=1;
UCCP=zeros(size(VARrange,2),1);
for VAR=VARrange
%% training
[r,o]=ro(128,128);
pz1=r>1;
OBJ=100;
trainLabels =zeros(OBJ,1);
trainData=zeros(OBJ,NoF);
for i=1:1:OBJ
        I=imread(['Dateset\training set\obj',num2str(i),'__0.png']);
        I(pz1)=0;
        trainLabels(i,1)=i;
        trainData(i,:)=features(double(I),NoF,BF)';
end
%% testing
testLabels =zeros(OBJ*36,1);
testData=zeros(OBJ*36,NoF);
for i=1:1:OBJ
    for j=0:1:35
        I=imread(['Dateset\testing set\obj',num2str(i),'__',num2str(j),'.png']);
        NI=imnoise(I,'gaussian',0,VAR);
        NI(pz1)=0;
        k=(i-1)*36+j+1;
        testLabels(k,1)=i;
        testData(k,:)=features(double(NI),NoF,BF)';
    end
end
%% OUTPUT
Mdl = fitcknn(trainData,trainLabels,'NumNeighbors',1);
label = predict(Mdl,testData);
accuracy = length(find(label == testLabels))/(OBJ*36)*100;
UCCP(flg,1)=accuracy;
if mod(flg,2)==1
    disp(['	',num2str(VAR),'			',num2str(accuracy)]);
else
    disp(['	',num2str(VAR),'		',num2str(accuracy)]);
end
flg=flg+1;
close all;
end
beep;
        
