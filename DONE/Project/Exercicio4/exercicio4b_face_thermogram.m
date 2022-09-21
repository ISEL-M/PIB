function exercicio4b_face_thermogram()
close all;
clc

imgs = imageDatastore("./NoisyImages/face_thermogram","FileExtensions",[".jpg",".png"]);
read(imgs);

original_image = imread('./NoisyImages/face_thermogram/face_thermogram.png');
    
for i = 1:4
    newImg = read(imgs);
      
    if rem(i,2)~=0
        newImg = newImg/(2*i);
    end
    newImg = histeq(newImg, imhist(original_image));
    newImg = medfilt2(newImg);
    
    MSE = immse(original_image,newImg);
    MAE = mae(original_image,newImg);
    n = i + 1;
    figure(1);
    subplot(3,2,1);imshow(original_image);title('Original image without any noise/blur');
    subplot(3,2,n);imshow(newImg);title(sprintf('Image %d after using DIP technique: MSE = %.2f / MAE = %.2f',i, MSE, MAE));
    %Para uma observa��o melhor, descomentar a linha abaixo e comentar
    %as tr�s acima
    %imshowpair(original_image, newImg, 'montage');title(sprintf('Original image without any noise x Image after using DIP technique: MSE = %.2f / MAE = %.2f', MSE, MAE));
end