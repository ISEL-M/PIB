function four_b()
clc;
close all;
import mlreportgen.dom.*;

folder = './Face-Images/*.jpg';
ds = imageDatastore(folder);

% usage of Viola-Jones algorithm
faceDetector = vision.CascadeObjectDetector;

while hasdata(ds)
   input = read(ds);
   detector = faceDetector(input);
   face = insertObjectAnnotation(input,'rectangle',detector,'Face'); 

    obj = step(faceDetector,input);
    n=size(obj,1);
    for i = 1:n
        output = imcrop(face,obj(i,:));        
    end
    
    figure;
    imshow(output);
    
end

end