function Exercicio_3c()
    close all;
    clc
        
    imds = imageDatastore('GrayscaleImages/*.*');
    imgs = readall(imds);  
    
    olhoRijo = imread('GrayscaleImages/iris.png');
    
    for idx = 1:length(imgs)
        fprintf(' --- Figure %d ---\n', idx);
        I = imgs{idx};
        I2 = histeq(I);
        I3 = histeq(I, imhist(olhoRijo));

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
        
        mi3  = min(min(I3));
        mx3 = max(max(I3));
        %fprintf(' Min=%d, Max=%d \n', mi, mx);
        
        Brilho = mean2(I);
        Contraste = mx-mi;
        H = entropy(I);
        fprintf('Original: Constraste=%d, Brilho=%d , Entropia=%d \n', Contraste, Brilho, H);

        Brilho2 = mean2(I2);
        Contraste2 = mx2-mi2;
        H2 = entropy(I2);
        fprintf('Improved: Constraste=%d, Brilho=%d , Entropia=%d \n', Contraste2, Brilho2, H2);
        
        Brilho3 = mean2(I3);
        Contraste3 = mx3-mi3;
        H3 = entropy(I3);
        fprintf('Improved w/ iris.png: Constraste=%d, Brilho=%d , Entropia=%d \n', Contraste3, Brilho3, H3);
        
        f = figure;
        f.Position = [200 200 500 550];
        s1  =  subplot(3,2,1);
          imshow(I);
        title('Original Image');
        s2  =  subplot(3,2,2);
          imhist(I);
        title('Histogram');
        s2  =  subplot(3,2,3);
          imshow(I2);
        title('Improved Image');
        s2  =  subplot(3,2,4);
          imhist(I2);
        title('Histogram Improved');
        s2  =  subplot(3,2,5);
          imshow(I3);
        title('Improved Image w/ iris.png');
        s2  =  subplot(3,2,6);
          imhist(I3);
        title('Histogram Improved w/ iris.png');
        
        fprintf('\n');
    end
end

