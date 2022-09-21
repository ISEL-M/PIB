function exercicio2()
    clc
    close all
    
    function [imageAdjusted, imageColored] = grayToColor(image, contrastL, contrastH, colorMap, nColors)
        % image -> gray scale image
        % contrastL -> low contrast cut off
        % contrastH -> hight contrast cut off
        % colorMap ->
        % 'parula','hsv','hot','cool','spring','summer','autumn','winter','gray','bone','copper','pink','lines','colorcube','prism','flag'
        % nColors -> number of colors, aka number of color slices
        
        imageAdjusted = imadjust(image,[contrastL contrastH],[]);
        fh = str2func(colorMap);
        imageColored = ind2rgb(gray2ind(imageAdjusted, nColors),fh(nColors));
    end

    %%%% CT %%%%
    % focus of the image: center and top left
    image = imread('./Medical-Images/CT.jpg');
    [imageAdjusted, imageColored] = grayToColor(image, 0.1, 0.7, 'jet', 256);   
    imwrite(imageColored, './Colored-Images/colored_CT.png');

    f = figure;
    f.WindowState = 'maximized';
    s1 = subplot(1,2,1);
        imshow(image);
    title('Original');
    s3 = subplot(1,2,2);
        imshow(imageColored);
    title('Pseudo-color');
    
    
    %%%% face_thermogram %%%%
    % focus of the image: temperature of the face
    image = imread('./Medical-Images/face_thermogram.png');
    [imageAdjusted, imageColored] = grayToColor(image, 0.0, 1.0, 'jet', 256);
    imwrite(imageColored, './Colored-Images/colored_face_thermogram.png');

    f = figure;
    f.WindowState = 'maximized';
    s1 = subplot(1,2,1);
        imshow(image);
    title('Original');
    s3 = subplot(1,2,2);
        imshow(imageColored);
    title('Pseudo-color');
    
    
    %%%% finger %%%%
    % focus of the image: details of the finger print
    image = imread('./Medical-Images/finger.png');
    [imageAdjusted, imageColored] = grayToColor(image, 0.5, 0.6, 'gray', 2);
    imwrite(imageColored, './Colored-Images/colored_finger.png');

    f = figure;
    f.WindowState = 'maximized';
    s1 = subplot(1,2,1);
        imshow(image);
    title('Original');
    s2 = subplot(1,2,2);
        imshow(imageColored);
    title('Pseudo-color');
    
    
    %%%% iris %%%%
    % focus of the image: details of the iris
    image = imread('./Medical-Images/iris.png');
    [imageAdjusted, imageColored] = grayToColor(image, 0.0, 0.8, 'parula', 64);
    imwrite(imageColored, './Colored-Images/colored_iris.png');

    f = figure;
    f.WindowState = 'maximized';
    s1 = subplot(1,2,1);
        imshow(image);
    title('Original');
    s2 = subplot(1,2,2);
        imshow(imageColored);
    title('Pseudo-color');
    %}
    
    
    %%%% MR %%%%
    % focus of the image: center of the image
    image = imread('./Medical-Images/MR.jpg');
    [imageAdjusted, imageColored] = grayToColor(image, 0.0, 0.5, 'jet', 64);
    imwrite(imageColored, './Colored-Images/colored_MR.png');

    f = figure;
    f.WindowState = 'maximized';
    s1 = subplot(1,2,1);
        imshow(image);
    title('Original');
    s2 = subplot(1,2,2);
        imshow(imageColored);
    title('Pseudo-color');
    
    
    %%%% PET %%%%
    % focus of the image: coloring human
    image = imread('./Medical-Images/PET.png');
    [imageAdjusted, imageColored] = grayToColor(image, 0.0, 0.8, 'hot', 256);
    imwrite(imageColored, './Colored-Images/colored_PET.png');

    f = figure;
    f.WindowState = 'maximized';
    s1 = subplot(1,2,1);
        imshow(image);
    title('Original');
    s2 = subplot(1,2,2);
        imshow(imageColored);
    title('Pseudo-color');
    
    
    %%%% Thyroid %%%%
    % focus of the image: red circle inside the thyroid
    image = imread('./Medical-Images/Thyroid.tif');
    image = image(:,:,1);
    [imageAdjusted, imageColored] = grayToColor(image, 0.0, 0.6, 'hsv', 16);
    imwrite(imageColored, './Colored-Images/colored_Thyroid.png');

    f = figure;
    f.WindowState = 'maximized';
    s1 = subplot(1,2,1);
        imshow(image);
    title('Original');
    s2 = subplot(1,2,2);
        imshow(imageColored);
    title('Pseudo-color');
    
    
    %%%% XRay %%%%
    % focus of the image: skin removed, only the bones show
    image = imread('./Medical-Images/XRay.png');
    [imageAdjusted, imageColored] = grayToColor(image, 0.2, 1.0, 'bone', 256);
    imwrite(imageColored, './Colored-Images/colored_XRay.png');

    f = figure;
    f.WindowState = 'maximized';
    s1 = subplot(1,2,1);
        imshow(image);
    title('Original');
    s2 = subplot(1,2,2);
        imshow(imageColored);
    title('Pseudo-color');
end