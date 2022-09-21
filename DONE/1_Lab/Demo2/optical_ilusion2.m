%
% ISEL - Instituto Superior de Engenharia de Lisboa.
%
% MEIC - Mestrado em Engenharia Informatica e de Computadores.
% MEIM - Mestrado em Engenharia Informática e Multimédia.
% 
% PIB - Processamento de Imagem e Biometria.
%
% optical_ilusion2.m
% Função que mostra um efeito de ilusão ótica do sistema visual humano.
%
function optical_ilusion2() 

% Fechar todas as janelas de figuras.
close all;

% Limpar a consola.
clc

blk = 100*ones(64,64);
  
I1  = 10 + zeros(256, 256);
I1( 96:159, 96:159 ) = blk;
I1 = uint8(I1);

I2  = 128 + zeros(256, 256);
I2( 96:159, 96:159 ) = blk;
I2 = uint8(I2);

I3  = 250 + zeros(256, 256);
I3( 96:159, 96:159 ) = blk;
I3 = uint8(I3);

figure(1);
subplot(131); imshow(I1); colormap('gray');
subplot(132); imshow(I2); colormap('gray');
subplot(133); imshow(I3); colormap('gray');
impixelinfo;

figure(2);
subplot(131); imhist(I1); colormap('gray');
subplot(132); imhist(I2); colormap('gray');
subplot(133); imhist(I3); colormap('gray');
impixelinfo;

end


