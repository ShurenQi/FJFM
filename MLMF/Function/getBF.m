function [BF,NoF,p,q,alpha]=getBF(MODE,sz1,sz2,maxorder)
p=0;q=0;alpha=0;
%% PZM    
if MODE==1
    NoF=(maxorder+1)^2;
    indx=1;
    BF=cell(1,NoF);
    [rho,theta]=ro(sz1,sz2);
    pz=rho>1;
    r =rho; r(pz)= 10; r(~pz)= rho(~pz); rho =r;
    for order=0:1:maxorder
        for repetition=-order:1:order
            R=getPZM_RadialPoly(order,repetition,rho);
            pupil =R.*exp(-1j*repetition * theta);
            BF{1,indx}=pupil;
            indx=indx+1;
        end
    end
%% OFMM
elseif MODE==2
    NoF=(maxorder+1)*(2*maxorder+1);
    indx=1;
    BF=cell(1,NoF);
    [rho,theta]=ro(sz1,sz2);
    pz=rho>1;
    r =rho; r(pz)= 10; r(~pz)= rho(~pz); rho =r;
    for order=0:1:maxorder
        R=getOFMM_RadialPoly(order,rho);
        for repetition=-maxorder:1:maxorder
            pupil =R.*exp(-1j*repetition * theta);
            BF{1,indx}=pupil;
            indx=indx+1;
        end
    end
%% CHFM
elseif MODE==3
    NoF=(maxorder+1)*(2*maxorder+1);
    indx=1;
    BF=cell(1,NoF);
    [rho,theta]=ro(sz1,sz2);
    pz=rho>1;
    r =rho; r(pz)= 10; r(~pz)= rho(~pz); rho =r;
    for order=0:1:maxorder
        R=getCHFM_RadialPoly(order,rho);
        for repetition=-maxorder:1:maxorder
            pupil =R.*exp(-1j*repetition * theta);
            BF{1,indx}=pupil;
            indx=indx+1;
        end
    end
%% PJFM
elseif MODE==4
    NoF=(maxorder+1)*(2*maxorder+1);
    indx=1;
    BF=cell(1,NoF);
    [rho,theta]=ro(sz1,sz2);
    pz=rho>1;
    r =rho; r(pz)= 10; r(~pz)= rho(~pz); rho =r;
    for order=0:1:maxorder
        R=getPJFM_RadialPoly(order,rho);
        for repetition=-maxorder:1:maxorder
            pupil =R.*exp(-1j*repetition * theta);
            BF{1,indx}=pupil;
            indx=indx+1;
        end
    end
%% PCET    
elseif MODE==5
    NoF=(2*maxorder+1)^2; 
    BF=cell(1,NoF);
    [rho,theta]=ro(sz1,sz2);
    pz=rho>1;
    r =rho; r(pz)= 10; r(~pz)= rho(~pz); rho =r;
    indx=1;
    for order=-maxorder:1:maxorder
        R=exp(-1j*2*pi*order.*(rho.^2))/sqrt(pi);
        for repetition=-maxorder:1:maxorder
            pupil =R.*exp(-1j*repetition * theta);
            BF{1,indx}=pupil;
            indx=indx+1;
        end
    end
%% GPCET    
elseif MODE==6
    NoF=(2*maxorder+1)^2;
    BF=cell(1,NoF);
    [rho,theta]=ro(sz1,sz2);
    pz=rho>1;
    r =rho; r(pz)= 10; r(~pz)= rho(~pz); rho =r;
    indx=1;
    disp('Parameter Setting: alpha>0;');
    alpha = input('alpha=');
    if  alpha<=0 
        disp('Error!');
        return;
    end
    for order=-maxorder:1:maxorder
        R=sqrt(alpha*rho.^(alpha-2)).*exp(1j*2*pi*order.*(rho.^alpha))/sqrt(pi);
        for repetition=-maxorder:1:maxorder
            pupil =R.*exp(-1j*repetition * theta);
            BF{1,indx}=pupil;
            indx=indx+1;
        end
    end  
%% FOFMM    
elseif MODE==7
    NoF=(maxorder+1)*(2*maxorder+1);
    BF=cell(1,NoF);
    [rho,theta]=ro(sz1,sz2);
    pz=rho>1;
    r =rho; r(pz)= 10; r(~pz)= rho(~pz); rho =r;
    indx=1;    
    disp('Parameter Setting: alpha>0;');
    alpha = input('alpha=');
    if  alpha<=0 
        disp('Error!');
        return;
    end
    for order=0:1:maxorder
        R=getFOFMM_RadialPoly(order,rho,alpha);
        for repetition=-maxorder:1:maxorder
            pupil =R.*exp(-1j*repetition * theta);
            BF{1,indx}=pupil*1;
            indx=indx+1;
        end
    end 
%% FCHFM    
elseif MODE==8
    NoF=(maxorder+1)*(2*maxorder+1);
    BF=cell(1,NoF);
    [rho,theta]=ro(sz1,sz2);
    pz=rho>1;
    r =rho; r(pz)= 10; r(~pz)= rho(~pz); rho =r;
    indx=1;
    disp('Parameter Setting: alpha>0;');
    alpha = input('alpha=');
    if  alpha<=0 
        disp('Error!');
        return;
    end
    for order=0:1:maxorder
        R=getFCHFM_RadialPoly(order,rho,alpha);
        for repetition=-maxorder:1:maxorder
            pupil =R.*exp(-1j*repetition * theta);
            BF{1,indx}=pupil*1;
            indx=indx+1;
        end
    end 
%% FJFM-MLMF
elseif MODE==9
    NoF=(maxorder+1)*(2*maxorder+1)*5;
    BF=cell(1,NoF);
    [rho,theta]=ro(sz1,sz2);
    pz=rho>1;
    r =rho; r(pz)= 10; r(~pz)= rho(~pz); rho =r;
    indx=1;
    disp('Parameter Setting: p-q>-1, q>0;');
    p = input('p=');
    q = input('q=');
    if  p-q<=-1 || q<=0 
        disp('Error!');
        return;
    end
    % (0.25)
    alpha=0.25;
    for order=0:1:maxorder
        R=getFJFM_RadialPoly(order,rho,p,q,alpha);
        for repetition=-maxorder:1:maxorder
            pupil =R.*exp(-1j*repetition * theta);
            w=(order+1)*2^(2-abs(log2(alpha)));
            BF{1,indx}=pupil*w;
            indx=indx+1;
        end
    end
    % (0.5)
    alpha=0.5;
    for order=0:1:maxorder
        R=getFJFM_RadialPoly(order,rho,p,q,alpha);
        for repetition=-maxorder:1:maxorder
            pupil =R.*exp(-1j*repetition * theta);
            w=(order+1)*2^(2-abs(log2(alpha)));
            BF{1,indx}=pupil*w;
            indx=indx+1;
        end
    end
    % (1)
    alpha=1;
    for order=0:1:maxorder
        R=getFJFM_RadialPoly(order,rho,p,q,alpha);
        for repetition=-maxorder:1:maxorder
            pupil =R.*exp(-1j*repetition * theta);
            w=(order+1)*2^(2-abs(log2(alpha)));
            BF{1,indx}=pupil*w;
            indx=indx+1;
        end
    end
   % (2)
    alpha=2;
    for order=0:1:maxorder
        R=getFJFM_RadialPoly(order,rho,p,q,alpha);
        for repetition=-maxorder:1:maxorder
            pupil =R.*exp(-1j*repetition * theta);
            w=(order+1)*2^(2-abs(log2(alpha)));
            BF{1,indx}=pupil*w;
            indx=indx+1;
        end
    end
   % (4)
    alpha=4;
    for order=0:1:maxorder
        R=getFJFM_RadialPoly(order,rho,p,q,alpha);
        for repetition=-maxorder:1:maxorder
            pupil =R.*exp(-1j*repetition * theta);
            w=(order+1)*2^(2-abs(log2(alpha)));
            BF{1,indx}=pupil*w;
            indx=indx+1;
        end
    end
end
end

