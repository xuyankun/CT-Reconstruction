%% Clean Environment
clc
clear
close all

%% load data
% load('data.mat')
load('data2.mat')
% g and g2 are two sinogram data to be reconstructed

%% Back projection

BPI = BackProjection(g2,180);

figure(1)
imagesc(BPI) 
colormap gray
axis('off')

%% Filtered Back Projection method

FBPI = FilteredBackProjection(g2,180,0);

figure(2)
imagesc(FBPI)
colormap gray
axis('off')

%%

CBPI = ConvolutionBackProjection(g2,180,0);

figure(3)
imagesc(CBPI)
colormap gray
axis('off')




