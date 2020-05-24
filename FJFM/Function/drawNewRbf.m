close all;
clc;
clear;

alpha=2;
P=2;
Q=2;
Ymax=5;
n=[0 1 2 3 4];
clmap={[0,0,255],[255,0,0],[0,255,0],[0,0,30],[255,25,186]};
figure;
for i=n
    rho=0:0.001:1;
    RBF=getRP_Recursive(i,rho,P,Q,alpha);
    hold on
    plot(rho,RBF,'LineWidth',2,'color',clmap{mod(i,5)+1}./255);
end
set(gcf, 'position', [0 0 666 500]);
set(gca,'fontsize',20,'FontName','Times New Roman');
ylabel(['\itJ_{n}\rm(',num2str(alpha),', ',num2str(P),', ',num2str(Q),', \itr\rm)']);xlabel('\itr');
h=legend('\itn\rm = 0','\itn\rm = 1','\itn\rm = 2','\itn\rm = 3','\itn\rm = 4','Location','southeast'); %'Location','southwest'
set(h,'FontName','Times New Roman');
set(h,'fontsize',20);
axis([0,1,-Ymax,Ymax]);
set(gca,'XTick',0:0.2:1); 
set(gca,'YTick',-5:2:5);

%%
clear all
clc
P=2;
Q=2;
alpha=[0.25,0.5,1,2,4];
NL=[0,0;1,1;2,2;3,3;4,4;5,5]+1;
blocksize=1000;
len1   = size(NL,1);
len2   = size(alpha,2);
BF = zeros(blocksize,blocksize,len1*len2);
[X,Y] = meshgrid(1:blocksize,1:blocksize);
r  = sqrt(((2.*Y-blocksize-1).^2+(2.*X-blocksize-1).^2)/(blocksize.^2));
theta = atan2(-(2.*Y-blocksize-1),   (2.*X-blocksize-1));
mask  = (r<=0.98);
for j = 1:len2
    for i = 1:len1
        n = NL(i,1);
        m = NL(i,2);
        a = alpha(j);
        BF(:,:,(j-1)*len1+i) = mask.*getRP_Recursive(n,r,P,Q,a).*exp(1i*m*theta);
    end
end;
h=figure;
set(h,'position',[0 0 800 700]);
ha = tight_subplot(len2,len1,[.01 .01],[.02 .02],[.02 .02]);
for j = 1:len2
    for i = 1:len1
        axes(ha((j-1)*len1+i));
        pa=real(BF(:,:,(j-1)*len1+i));
        imshow(pa,[-pi,pi])
        axis equal
        axis([0,blocksize,0,blocksize]);
        colormap(jet(2000))
        set(gca,'XColor','white')
        set(gca,'YColor','white')
        set(gca,'XTick', []);
        set(gca,'YTick', []);       
    end
end;
% print(gcf,'-r600','-dtiff',['FJFM.tiff']);
