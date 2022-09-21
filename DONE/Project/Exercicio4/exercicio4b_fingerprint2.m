function exercicio4b_fingerprint()
close all;
clc

imgs = imageDatastore("./NoisyImages/finger","FileExtensions",[".jpg",".png"]);
original_image = imread('./NoisyImages/finger/finger.png');


for i = 1:5
    %padding
    Ip = original_image;
    Ip = uint8(Ip);
    Fp = fftshift(fft2(Ip));
    
    Ip2 = read(imgs);
    Ip2 = uint8(Ip2);
    Fp2 = fftshift(fft2(Ip2));
    
    
    Fp3 = Fp./Fp2;
    Fp2 = Fp2.*Fp3;
    
    If = ifft2 ( ifftshift(Fp2) ) ;
    newImg = uint8(real(If));
  
    
    aux = imdivide(original_image, newImg);
    newImg = immultiply(newImg, aux);
    
    MSE = immse(original_image,newImg);
    MAE = mae(original_image,newImg);
    n = i + 1;
    figure(1);
    subplot(3,2,1);imshow(original_image);title('Original image without any noise/blur');
    subplot(3,2,n);imshow(newImg);title(sprintf('Image %d after using DIP technique: MSE = %.2f / MAE = %.2f',i, MSE, MAE));
    %imshowpair(original_image, newImg, 'montage');title(sprintf('Original image without any noise/blur x Image after using DIP technique: MSE = %.2f / MAE = %.2f', MSE, MAE));
end