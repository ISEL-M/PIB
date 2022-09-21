function four_d()
clc;
close all;

folder = './Face-Images/*.jpg';
ds = imageDatastore(folder);

faceDetector = vision.CascadeObjectDetector;

while hasdata(ds)
   input = read(ds);
   obj = step(faceDetector,input);
   
    n=size(obj,1);
%     for i = 1:n
%         watermark
%         wm = imread('watermark_example.jpg');
%         new_size = size(wm)/10;
%         new_size = [new_size(1), new_size(2)];
%         wmResize = imresize(wm,new_size,'bilinear');
%         
%         temp = zeros(size(input),'uint8');
%         [rows, cols, depth] = size(wmResize);
% 
%         X = 20;
%         Y = 20;
%         temp(X:X+rows-1,Y:Y+cols-1,:) = wmResize;
% 
%         alpha = 1;
%         watermarked_image = imadd(temp, input);
%     end
    for i = 1:size(obj)
        crop=obj(i,:);
        crop(4)=round(crop(4)/5);
        img_crop = imcrop(input, crop);
        [filter , map, alphachannel] = imread('flower_crown.png');
        s = size(img_crop)
        
        filter = imresize(filter,[s(1), s(2)]);
        
        alpha = 1;
        ki = 1;
        for i = crop(2):crop(2)+crop(4)
            kj = 1;
            for j = crop(1):crop(1)+crop(3)
                if filter(ki,kj,:)~=0
                    input(i,j,:) = filter(ki,kj,:);
                end
                kj = kj+1;
            end
            ki = ki+1;
        end
    end
    figure;
    imshow(input);
    
end

end