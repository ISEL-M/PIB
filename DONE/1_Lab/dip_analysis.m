function dip_analysis(fileName)    
    % Ler a imagem a partir do ficheiro
    I = imread(fileName);

    % Resolucao espacial
    [M, N] = size(I);
    
    % Histograma
    hist = imhist(I); 

    % Numero total de pixeis e pixeis districtos
    nPixels = M*N;
    distinctPixel = length(find(hist>0));

    % Procurar quais os pixeis mais/menos frequentes
    maxRep = max(hist);
    minRep = min(hist);
    lessRepeatPix = min(find(hist==minRep));
    moreRepeatPix = max(find(hist==maxRep));

    % Calcular o valor minimo e maximo para calcular o contraste
    mi = min(min(I));
    mx = max(max(I));
    
    % Calculo de brilho/contraste/entropia
    brilho = mean2(I);
    contraste = mx-mi;
    H = entropy(I);

    % Mostrar a informacao
    fprintf(' ---- %s ----\n', fileName);
    fprintf('Pixel mais frequente=%d\nPixel menos frequente=%d\n', moreRepeatPix, lessRepeatPix);
    fprintf('Numero total de pixeis=%d\nNumero de pixeis distintos=%d\n', nPixels, distinctPixel);
    fprintf('Entropia=%d\nBrilho=%d\nContraste=%d\n\n', H, brilho, contraste);
end

