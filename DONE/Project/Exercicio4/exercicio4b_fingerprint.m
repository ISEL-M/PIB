function exercicio4b_fingerprint()
close all;
clc

imgs = imageDatastore("./NoisyImages/finger","FileExtensions",[".jpg",".png"]);
original_image = imread('./NoisyImages/finger/finger.png');
read(imgs);

for i = 1:5
    aux_original = original_image;
    aux_original = padarray(original_image,size(original_image),0,'post');
    aux_original = uint8(aux_original);
    Fp_ref = fftshift(fft2(aux_original));
    
    
    newImg = read(imgs);
    newImg = histeq(newImg, imhist(original_image));
    aux = imdivide(original_image, newImg);
    newImg = immultiply(newImg, aux);
    
    newImg = padarray(newImg,size(original_image),0,'post');
    newImg = uint8(newImg);
    Fp_new = fftshift(fft2(newImg));
%     
%     Fp_aux = imag(Fp_new-Fp_ref);
%     max(Fp_aux);
%     avg_error = max(Fp_aux);
%     avg_error = median(avg_error)
    
    
    P = size(newImg,1);
    Q = size(newImg,2);
    
    
    %frequency
    H = zeros( P, Q );
    for u=1 : P
        for v=1 : Q
            dif = Fp_new(u,v) - Fp_ref(u,v);
            
            if dif>=5e3%|| 1
                H(u,v)=1;
            end
        end
    end
    
    H(round(P/2), round(Q/2)) = 1;
    
    G = Fp_new .* H;
    newImg = ifft2 ( ifftshift(G) ) ;
    newImg = uint8(real(newImg));
    
    newImg = uint8(newImg( 1:size(original_image,1), 1:size(original_image,2)));
    
    MSE = immse(original_image,newImg);
    MAE = mae(original_image,newImg);
    n = i + 1;
    figure(1);
    subplot(3,2,1);imshow(original_image);title('Original image without any noise/blur');
    subplot(3,2,n);imshow(newImg);title(sprintf('Image %d after using DnewImg technique: MSE = %.2f / MAE = %.2f',i, MSE, MAE));
    %imshowpair(original_image, newImg, 'montage');title(sprintf('Original image without any noise/blur x Image after using DnewImg technique: MSE = %.2f / MAE = %.2f', MSE, MAE));
end