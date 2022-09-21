function Exercicio_3a()
    close all;
    clc
    
    imds = imageDatastore('GrayscaleImages/*.*');
    imgs = readall(imds);    
    
    for idx = 1:length(imgs)
        fprintf(' --- Figure %d ---\n', idx);
        I = imgs{idx};
        I2 = imcomplement(I); % https://www.mathworks.com/help/images/ref/imcomplement.html

        f = figure;
        s1  =  subplot(2,2,1);
          imshow(I);
        title('Original Image');
        s2  =  subplot(2,2,2);
          imhist(I);
        title('Histogram');
        s2  =  subplot(2,2,3);
          imshow(I2);
        title('Inverted Image');
        s2  =  subplot(2,2,4);
          imhist(I2);
        title('Histogram Inverted');

        % Obter as dimens??es (resolu????o da imagem).
        [M, N] = size(I);

        hist = imhist(I);
        hist2 = imhist(I2);

        % Imprimir mensagem com as dimens??es e resolu????o da imagem.
        NPixels = M*N;
        DistinctPixel=length(find(hist>0));
        fprintf('Pixeis Distintos=%d, Total de Pixeis=%d \n', DistinctPixel, NPixels);

        maxRep = max(hist);
        minRep = min(hist);

        maxRep2 = max(hist2);
        minRep2 = min(hist2);

        LessRepeatPix = find(hist==minRep);
        MoreRepeatPix = find(hist==maxRep);

        LessRepeatPix2 = find(hist2==minRep2);
        MoreRepeatPix2 = find(hist2==maxRep2);


        % fprintf(' Mais Frequente=%d, menos Frequente=%d \n', MoreRepeatPix, LessRepeatPix);

        % Calcular a energia da imagem.
        % E = sum(sum( I.^2 ));

        % Calcular a pot??ncia da imagem.
        % P = E / (M*N);

        % Calcular o valor m??dio da imagem.
        % m = sum(sum( I )) / (M*N);

        % fprintf(' Energy=%d, Power=%d, Mean=%.2f\n', E, P, m);

        % Calcular o valor m??nimo e valor m??ximo da imagem.
        mi = min(min(I));
        mx = max(max(I));

        mi2  = min(min(I2));
        mx2 = max(max(I2));
        % fprintf(' Min=%d, Max=%d \n', mi, mx);
        
        Brilho = mean2(I);
        Contraste = mx-mi;
        H = entropy(I);
        fprintf('Original: Constraste=%d, Brilho=%d , Entropia=%d \n', Contraste, Brilho, H);

        Brilho2 = mean2(I2);
        Contraste2 = mx2-mi2;
        H2 = entropy(I2);
        fprintf('Inverted: Constraste=%d, Brilho=%d , Entropia=%d \n', Contraste2, Brilho2, H2);
        
        fprintf('\n');
    end
end

