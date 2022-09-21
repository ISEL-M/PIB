function four_a()
clc;
close all;
import mlreportgen.dom.*;

folder = './Face-Images/*.jpg';
ds = imageDatastore(folder);

% usage of Viola-Jones algorithm
faceDetector = vision.CascadeObjectDetector;

while hasdata(ds)
   input = read(ds);
   obj = step(faceDetector,input);
    
    for i = 1:size(obj)
        crop=obj(i,:);
        img_crop = imcrop(input, crop);
        filter = fspecial('disk',10);
        blurred_img = imfilter(img_crop,filter);
        input(crop(2):crop(2)+crop(4),crop(1):crop(1)+crop(3),1:end) = blurred_img; 
    end
    
    figure;
    imshow(input);
    
end

end