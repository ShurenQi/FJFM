%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% T.-H. Chan, K. Jia, S. Gao, J. Lu, Z. Zeng, and Y. Ma, 
% "PCANet: A simple deep learning baseline for image classification?" 
% IEEE Trans. Image Processing, vol. 24, no. 12, pp. 5017-5032, Dec. 2015. 
% Tsung-Han Chan [chantsunghan@gmail.com]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code is slightly modified for experiment by Shuren Qi 
% i@srqi.email
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
clear all;
clc; 
addpath(genpath(pwd));
addpath('./Function/PCANet/Utils');
addpath('./Function/PCANet/Liblinear');
make;

TrnSize = 100; 
ImgSize = 32;

UCCP=zeros(7,1);
flg=1;

for VAR=0:0.05:0.3
%% Loading data %%
%% CASE1: training without rotation images
% % training
% [r,o]=ro(ImgSize,ImgSize);
% pz1=r>1;
% TrnData_ImgCell=cell(TrnSize,1);
% TrnLabels=zeros(TrnSize,1);
% for i=1:1:TrnSize
%         I=imread(['Dateset\training set\obj',num2str(i),'__0.png']);
%         I=imresize(I,[ImgSize,ImgSize]);
%         I(pz1)=0;
%         TrnData_ImgCell{i}=double(I);
%         TrnLabels(i,1)=i;
% end
% % testing
% TestData_ImgCell =cell(TrnSize*36,1);
% TestLabels=zeros(TrnSize*36,1);
% for i=1:1:TrnSize
%     for j=0:1:35
%         I=imread(['Dateset\testing set\obj',num2str(i),'__',num2str(j),'.png']);
%         I=imresize(I,[ImgSize,ImgSize]);
%         NI=imnoise(I,'gaussian',0,VAR);
%         NI(pz1)=0;
%         k=(i-1)*36+j+1;
%         TestData_ImgCell{k}=double(NI);
%         TestLabels(k,1)=i;
%     end
% end
% nTestImg = length(TestLabels);
%% CASE2: training with rotation images
% training
[r,o]=ro(ImgSize,ImgSize);
pz1=r>1;
TrnData_ImgCell =cell(TrnSize*36,1);
TrnLabels=zeros(TrnSize*36,1);
for i=1:1:TrnSize
    for j=0:1:35
        I=imread(['Dateset\testing set\obj',num2str(i),'__',num2str(j),'.png']);
        I=imresize(I,[ImgSize,ImgSize]);
        I(pz1)=0;
        k=(i-1)*36+j+1;
        TrnData_ImgCell{k}=double(I);
        TrnLabels(k,1)=i;
    end
end
% testing
TestData_ImgCell =cell(TrnSize*36,1);
TestLabels=zeros(TrnSize*36,1);
for i=1:1:TrnSize
    for j=0:1:35
        I=imread(['Dateset\testing set\obj',num2str(i),'__',num2str(j),'.png']);
        I=imresize(I,[ImgSize,ImgSize]);
        NI=imnoise(I,'gaussian',0,VAR);
        NI(pz1)=0;
        k=(i-1)*36+j+1;
        TestData_ImgCell{k}=double(NI);
        TestLabels(k,1)=i;
    end
end
nTestImg = length(TestLabels);


%% PCANet parameters %%
PCANet.NumStages = 2;
PCANet.PatchSize = [5 5];
PCANet.NumFilters = [8 8];
PCANet.HistBlockSize = [8 8];
PCANet.BlkOverLapRatio = 0.5;
PCANet.Pyramid = [];

fprintf('\n ====== PCANet Parameters ======= \n')
PCANet

%% PCANet Training %%
% fprintf('\n ====== PCANet Training ======= \n')
% % TrnData_ImgCell = mat2imgcell(double(TrnData),ImgSize,ImgSize,ImgFormat); % convert columns in TrnData to cells 
% tic; 
% [ftrain, V, BlkIdx] = PCANet_train(TrnData_ImgCell,PCANet,1); % BlkIdx serves the purpose of learning block-wise DR projection matrix; e.g., WPCA
% PCANet_TrnTime = toc;


%% PCA hashing over histograms %%
% c = 10; 
% fprintf('\n ====== Training Linear SVM Classifier ======= \n')
% display(['now testing c = ' num2str(c) '...'])
% tic;
% models = train(TrnLabels, ftrain', ['-s 1 -c ' num2str(c) ' -q']); % we use linear SVM classifier (C = 10), calling liblinear library
% LinearSVM_TrnTime = toc;

%% Load pre-trained models for CASE2 %%
load('models.mat')
load('V.mat')

%% PCANet Feature Extraction and Testing %%

fprintf('\n ====== PCANet Testing ======= \n')

nCorrRecog = 0;
RecHistory = zeros(nTestImg,1);

tic; 
for idx = 1:1:nTestImg
    ftest = PCANet_FeaExt(TestData_ImgCell(idx),V,PCANet); % extract a test feature using trained PCANet model 

    [xLabel_est, accuracy, decision_values] = predict(TestLabels(idx),...
        sparse(ftest'), models, '-q');
    
    if xLabel_est == TestLabels(idx)
        RecHistory(idx) = 1;
        nCorrRecog = nCorrRecog + 1;
    end
    
    if 0==mod(idx,nTestImg/1000); 
        fprintf('Accuracy up to %d tests is %.2f%%; taking %.2f secs per testing sample on average. \n',...
            [idx 100*nCorrRecog/idx toc/idx]); 
    end 
    
    TestData_ImgCell{idx} = [];
    
end
Averaged_TimeperTest = toc/nTestImg;
Accuracy = nCorrRecog/nTestImg; 

%% Results display %%
fprintf('\n ===== Results of PCANet, followed by a linear SVM classifier =====');
fprintf('\n     Testing Accuracy: %.4f%%', 100*Accuracy);
UCCP(flg,1)=Accuracy;
flg=flg+1;
end


    