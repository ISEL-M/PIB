function exercicio4b_squares()
close all;
clc

imgs = imageDatastore("./NoisyImages/squares","FileExtensions",(".gif"));
read(imgs);

original_image = imread('./NoisyImages/squares/squares.gif');

for i = 1:4
    newImg = read(imgs);
    
    newImg = medfilt2(newImg);
    
    newImg = imcomplement(newImg);
    
    newImg = imrotate(newImg,round(-5*i),'bilinear','crop');
    size_original = size(original_image);
    size_remove= (size(newImg) - size_original)/2+1;
    newImg = imcrop(newImg,[size_remove(1) size_remove(2) size_original-1]);
    
    
    MSE = immse(original_image,newImg);
    MAE = mae(original_image,newImg);
    n = i + 1;
    figure(1);
    subplot(3,2,1);imshow(original_image);title('Original image without any noise/blur');
    subplot(3,2,n);imshow(newImg);title(sprintf('Image %d after using DIP technique: MSE = %.2f / MAE = %.2f',i, MSE, MAE));
end