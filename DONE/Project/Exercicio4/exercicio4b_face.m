function exercicio4b_face()
close all;
clc

imgs = imageDatastore("./NoisyImages/face","FileExtensions",[".jpg",".png"]);
original_image = imread('./NoisyImages/face/face.jpg');
read(imgs);

figure;
subplot(3,2,1);imshow(original_image);title('Original image without any noise/blur');
for i = 1:4
    img = read(imgs);
    newImg = img;
    
    
    newImg = imsharpen(newImg,'Radius',1,'Amount',i*2);
    newImg = histeq(newImg, imhist(original_image));
    aux = imdivide(original_image, newImg);
    newImg = immultiply(newImg, aux);
    newImg = imgaussfilt(newImg, 1);

    
    MSE = immse(original_image,newImg);
    MAE = mae(original_image,newImg);
    n = i + 1;
    subplot(3,2,1);imshow(original_image);title('Original image without any noise/blur');
    subplot(3,2,n);imshow(newImg);title(sprintf('Image %d after using DIP technique: MSE = %.2f / MAE = %.2f',i, MSE, MAE));
    %imshowpair(original_image, newImg, 'montage');title(sprintf('Original image without any noise/blur x Image after using DIP technique: MSE = %.2f / MAE = %.2f', MSE, MAE));

end