function four_c()
clc;
close all;

folder = './Face-Images/*.jpg';
ds = imageDatastore(folder);

faceDetector = vision.CascadeObjectDetector;

while hasdata(ds)
   input = read(ds);
   obj = step(faceDetector,input);
   
    n=size(obj,1);
    for i = 1:n
        % watermark
        wm = imread('watermark_example.jpg');
        new_size = size(wm)/10;
        new_size = [new_size(1), new_size(2)];
        wmResize = imresize(wm,new_size,'bilinear');
        
        temp = zeros(size(input),'uint8');
        [rows, cols, depth] = size(wmResize);

        X = 20;
        Y = 20;
        temp(X:X+rows-1,Y:Y+cols-1,:) = wmResize;

        alpha = 1;
        watermarked_image = imadd(temp, input);
    end
    
    figure;
    imshow(watermarked_image);
    
end

end