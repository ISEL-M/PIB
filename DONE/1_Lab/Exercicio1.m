function Exercicio1()  
 
% Fechar todas as janelas de figuras.
close all;

% Limpar a consola.
clc

%Octave
%pkg load image

% Ler a imagem a partir do ficheiro.

% Binária
%I = imread('man_bw.tif');

% Níveis de cinzento
% I = imread('camera.gif');
I = imread('bird.gif');
%I = imread('lena.gif');
% I = 0.5 * imread('lena.gif');
% I = imread('squares.gif');


% Obter as dimensões (resolução da imagem).
hist=imhist(I); 
[M, N] = size(I);

% Imprimir mensagem com as dimensões e resolução da imagem.
NPixels=M*N;
DistinctPixel=length(find(hist>0));
fprintf(' Pixeis Distintos=%d, Total de Pixeis=%d \n', DistinctPixel, NPixels);

maxRep=max(hist);
minRep=min(hist);
 
LessRepeatPix=find(hist==minRep);
MoreRepeatPix=find(hist==maxRep);


% fprintf(' Mais Frequente=%d, menos Frequente=%d \n', MoreRepeatPix, LessRepeatPix);


% Calcular a energia da imagem.
% E = sum(sum( I.^2 ));

% Calcular a potência da imagem.
% P = E / (M*N);

% Calcular o valor médio da imagem.
% m = sum(sum( I )) / (M*N);

% fprintf(' Energy=%d, Power=%d, Mean=%.2f\n', E, P, m);

% Calcular o valor mínimo e valor máximo da imagem.
mi  = min(min(I));
mx = max(max(I));
% fprintf(' Min=%d, Max=%d \n', mi, mx);

Brilho=mean2(I);
Contraste=mx-mi;
H = entropy(I);
fprintf('C) Constraste=%d, Brilho=%d , Entropia=%d \n', Brilho, Contraste, H);

end

