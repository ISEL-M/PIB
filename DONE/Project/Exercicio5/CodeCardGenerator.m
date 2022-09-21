function CodeCardGenerator(maxRows, maxCols)
    fprintf("Generating... ");

    MAX_ROWS = maxRows;
    MAX_COLS = maxCols;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % hardcoded values, can be improved
    %
    FONT_SIZE = 32;
    %
    TABLE_VERT_START = 40;
    TABLE_HORZ_START = 80;
    %
    TABLE_HORZ_SPACE = 80;
    TABLE_VERT_SPACE = 50;
    %
    % background color channels
    BACKGROUND_RED = 0.0;
    BACKGROUND_GREEN = 0.8;
    BACKGROUND_BLUE = 0.8;
    %
    LETTERS = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % check if valic number of rows
    if MAX_ROWS > size(LETTERS)
        [z,lettersSize] = size(LETTERS);
        MAX_ROWS = lettersSize;
    end
    
    % set up image spatial resolution
    M = FONT_SIZE+(MAX_ROWS*TABLE_VERT_SPACE);
    N = (FONT_SIZE*2)+(MAX_COLS*TABLE_HORZ_SPACE);
    
     % new image
    image = zeros(M,N,3);
    
    % set background
    image(:,:,1)=BACKGROUND_RED;   % red channel
    image(:,:,2)=BACKGROUND_GREEN; % green channel
    image(:,:,3)=BACKGROUND_BLUE;  % blue Channel
    
    % add card content
    % this code can be simplified due to duplicated code
    progress = 0;   % progress percentage for console output
    progressShown = 0;
    for r = 1:MAX_ROWS+1
        % progress display
        progress = ((r-1)/MAX_ROWS)*100;
        if r>1
            fprintf(repmat('\b',1,progressText));
        end
        progressText = fprintf("%d", round(progress));
        
        
        for c = 1:MAX_COLS+1
            col = (c*TABLE_HORZ_SPACE)-(TABLE_HORZ_START-26);
            row = (r*TABLE_VERT_SPACE)-(TABLE_VERT_START+22);
            
            % table columns labels
            if r==1 && c>1
                R = rand(1);
                G = rand(1);
                B = rand(1);

                textColor = [0 0 0];
                if rem(c,2)==1
                    textColor = [R G B];
                end
                
                image = insertText(image, [col row], (c-1),'FontSize',FONT_SIZE,'TextColor',textColor,'AnchorPoint','CenterTop','BoxOpacity',0);
            end
            
            % table rows labels
            if r>1 && c==1
                R = rand(1);
                G = rand(1);
                B = rand(1);

                textColor = [0 0 0];
                if rem(r,2)==0
                    textColor = [R G B];
                end
                
                image = insertText(image, [col row], LETTERS(r-1),'FontSize',FONT_SIZE,'TextColor',textColor,'AnchorPoint','CenterTop','BoxOpacity',0);
            end
            
            % table content
            if r>1 && c>1
                R = rand(1);
                G = rand(1);
                B = rand(1);

                text1Color = [0 0 0];
                text2Color = [0 0 0];
                text3Color = [0 0 0];

                switch randi([1 3],1)
                    case 1
                        text1Color = [R G B];
                    case 2
                        text2Color = [R G B];
                    case 3
                        text3Color = [R G B];
                end

                text1 = sprintf('%d', randi(9));
                text2 = sprintf('%d', randi(9));
                text3 = sprintf('%d', randi(9));

                image = insertText(image, [col row], text1,'FontSize',FONT_SIZE,'TextColor',text1Color,'AnchorPoint',  'LeftTop','BoxOpacity',0);
                image = insertText(image, [col row], text2,'FontSize',FONT_SIZE,'TextColor',text2Color,'AnchorPoint','CenterTop','BoxOpacity',0);
                image = insertText(image, [col row], text3,'FontSize',FONT_SIZE,'TextColor',text3Color,'AnchorPoint', 'RightTop','BoxOpacity',0);
            end
        end
    end
    fprintf("\n");
    
    % generate gray variant
    gray = rgb2gray(image);
    
    % save images varables
    name = 'card_%dx%d_%s.%s';
    typeColor = 'rgb';
    typeGray = 'gray';
    extensionPNG = 'png';
    
    % save rgb PNG
    fileName = sprintf(name, maxRows, maxCols, typeColor, extensionPNG);
    imwrite(image, fileName);
    fprintf("Saved: %s\n", fileName);
    
    % save gray scale PNG
    fileName = sprintf(name, maxRows, maxCols, typeGray, extensionPNG);
    imwrite(gray, fileName);
    fprintf("Saved: %s\n", fileName);
        
    % show generated card
    f = figure;
    f.WindowState = 'maximized';
    s1  =  subplot(1,2,1);
      imshow(image);
    title('RBG Card');
    s2  =  subplot(1,2,2);
      imshow(gray);
    title('Gray scale Card');
end

