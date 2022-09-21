function Captcha(maxLetters, difficulty, seed)
    % Difficulty adds the previous difficult, ex: 2 includes 0 and 1
    % difficult = 0 -> plain text
    % difficult = 1 -> text distortion
    % difficult = 2 -> gaussian noise

    fprintf("Generating... ");
    
    if exist('seed','var')
        rng(seed)
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % hardcoded values, can be improved
    %
    FONT_SIZE = 32;
    %
    CENTER_VERT = 40;
    CENTER_HORZ = 80;
    %
    PADDING_HORZ = 0;
    PADDING_VERT = 20;
    %
    % background color channels
    BACKGROUND_RED = 1.0;
    BACKGROUND_GREEN = 1.0;
    BACKGROUND_BLUE = 1.0;
    %
    LETTERS = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
    [z,lettersSize] = size(LETTERS);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
    % set up image spatial resolution
    M = (FONT_SIZE*2)+PADDING_VERT;
    N = (FONT_SIZE*maxLetters)+PADDING_HORZ;
    
     % new image
    image = zeros(M,N,3);
    
    % set background
    image(:,:,1)=BACKGROUND_RED;   % red channel
    image(:,:,2)=BACKGROUND_GREEN; % green channel
    image(:,:,3)=BACKGROUND_BLUE;  % blue Channel
    
    text = "";
    % generate text
    for i = 1:maxLetters
        t = randi(lettersSize);
        text = text + LETTERS(t);
    end
    fprintf("%s\n", text);
    
    % print text to image
    image = insertText(image, [(N/2) (M/2)], cellstr(text),'FontSize',FONT_SIZE,'TextColor','black','AnchorPoint','Center','BoxOpacity',0);
    
    % distort fucntion
    function ret = shiftFunc(i, phase)
        ret = 2*sin((i*0.2)+phase)+2*sin(i*pi*0.05);
    end
    
    if difficulty >= 1
        % distort horizontally
        phase = randi(10);
        for i = 1:M
            k = round(shiftFunc(i, phase));
            image(i,:) = circshift(image(i,:),k,2);
        end

        % distort vertically (by rotating, 90? > distort > -90?; this can be improved by not rotating, but currently dont know how)
        image = imrotate(image, 90);
        for i = 1:N
            k = round(shiftFunc(i, phase));
            image(i,:) = circshift(image(i,:),k,2);
        end
        image = imrotate(image, -90);
    end
    
    if difficulty >= 2
        % add gaussian noise
        image = imnoise(image, 'gaussian', 0.4, 0.4);
    end
    
    % generate gray variant
    gray = rgb2gray(image);
    
    % save images varables
    name = 'captcha_%d_%s.%s';
    typeColor = 'rgb';
    typeGray = 'gray';
    extensionJPEG = 'jpeg';
    extensionPNG = 'png';
    
    % save color JPEG
    fileName = sprintf(name, difficulty, typeColor, extensionJPEG);
    imwrite(image, fileName);
    fprintf("Saved: %s\n", fileName);
    % save gray scale JPEG
    fileName = sprintf(name, difficulty, typeGray, extensionJPEG);
    imwrite(gray, fileName);
    fprintf("Saved: %s\n", fileName);
    
    % save color PNG
    fileName = sprintf(name, difficulty, typeColor, extensionPNG);
    imwrite(image, fileName);
    fprintf("Saved: %s\n", fileName);
    % save gray scale PNG
    fileName = sprintf(name, difficulty, typeGray, extensionPNG);
    imwrite(gray, fileName);
    fprintf("Saved: %s\n", fileName);
        
    % show generated card
    f = figure;
    %f.WindowState = 'maximized';
    s1  =  subplot(2,1,1);
      imshow(image);
    title('RBG Captcha');
    s2  =  subplot(2,1,2);
      imshow(gray);
    title('Gray scale Captcha');
end
