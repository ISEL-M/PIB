function exercicio4b_iris()
% close all;
clc

imgs = imageDatastore("./NoisyImages/iris","FileExtensions",[".jpg",".png"]);
read(imgs);

original_image = imread('./NoisyImages/iris/iris.png');

figure;
for i = 1:4 
    newImg = read(imgs);
    
    newImg = imgaussfilt(newImg,4);
    newImg = histeq(newImg, imhist(original_image));
    
    aux = imdivide(original_image, newImg);
    newImg = immultiply(newImg, aux);
    newImg = imgaussfilt(newImg,1);
    
    
    MSE = immse(original_image,newImg);
    MAE = mae(original_image,newImg);
    n = i + 1;
    subplot(3,2,1);imshow(original_image);title('Original image without any noise/blur');
    subplot(3,2,n);imshow(newImg);title(sprintf('Image after using DIP technique: MSE = %.2f / MAE = %.2f', MSE, MAE));
    %imshowpair(original_image, newImg, 'montage');title(sprintf('Original image without any noise/blur x Image after using DIP technique: MSE = %.2f / MAE = %.2f', MSE, MAE));
end