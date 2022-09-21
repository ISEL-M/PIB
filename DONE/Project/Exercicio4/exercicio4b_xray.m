function exercicio4b_xray()
clear all
clc

imgs = imageDatastore("./NoisyImages/xray","FileExtensions",[".jpg",".png"]);

read(imgs);

original_image = imread('./NoisyImages/xray/xray.png');

figure;
for i = 1:4
    newImg = read(imgs);
    
    
    newImg = histeq(newImg, imhist(original_image));
    newImg = imgaussfilt(newImg, 1); 
    
    newImg = imsharpen(newImg,'Radius',1/i,'Amount',i);
    
    aux = imdivide(original_image, newImg);
    newImg = immultiply(newImg, aux);
    
    newImg = imgaussfilt(newImg, 1); 
    
    
    MSE = immse(original_image,newImg);
    MAE = mae(original_image,newImg);
    n = i + 1;
    subplot(3,2,1);imshow(original_image);title('Original image without any noise/blur');
    subplot(3,2,n);imshow(newImg);title(sprintf('Image %d after using DIP technique: MSE = %.2f / MAE = %.2f',i, MSE, MAE));
end