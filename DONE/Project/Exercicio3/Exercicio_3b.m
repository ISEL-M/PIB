function Exercicio_3b()
    close all;
    clc
        
    imds = imageDatastore('GrayscaleImages/*.*');
    imgs = readall(imds);    
    
    for idx = 1:length(imgs)
        fprintf(' --- Figure %d ---\n', idx);
        I = imgs{idx};
        I2 = imadjust(I); % https://www.mathworks.com/help/images/ref/imadjust.html

        % Obter as dimens??es (resolu????o da imagem).
        [M, N] = size(I);

        hist = imhist(I);
        hist2 = imhist(I2);

        % Imprimir mensagem com as dimens??es e resolu????o da imagem.
        NPixels = M*N;

        % Calcular o valor m??dio da imagem.
        m = sum(sum( I )) / (M*N);

        % fprintf(' Energy=%d, Power=%d, Mean=%.2f\n', E, P, m);

        % Calcular o valor m??nimo e valor m??ximo da imagem.
        mi = min(min(I));
        mx = max(max(I));
        
        mi2  = min(min(I2));
        mx2 = max(max(I2));
        %fprintf(' Min=%d, Max=%d \n', mi, mx);
        
        Brilho = mean2(I);
        Contraste = mx-mi;
        H = entropy(I);
        fprintf('Original: Constraste=%d, Brilho=%d , Entropia=%d \n', Contraste, Brilho, H);

        Brilho2 = mean2(I2);
        Contraste2 = mx2-mi2;
        H2 = entropy(I2);
        fprintf('Improved: Constraste=%d, Brilho=%d , Entropia=%d \n', Contraste2, Brilho2, H2);
        
        f = figure;
        s1  =  subplot(2,2,1);
          imshow(I);
        title('Original Image');
        s2  =  subplot(2,2,2);
          imhist(I);
        title('Histogram');
        s2  =  subplot(2,2,3);
          imshow(I2);
        title('Improved Image');
        s2  =  subplot(2,2,4);
          imhist(I2);
        title('Histogram Improved');
        
        fprintf('\n');
    end
end

