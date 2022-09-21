function [ridge, outImg, outImg_ridge, outImg_bif, I_original] = exercicio3_b(I_original)
    if nargin < 1
        I_original = imread('test.bmp');
    end
    I=imbinarize(I_original);
    start_x=size(I,1);
    start_y=size(I,2);
    end_x=1;
    end_y=1;
    for x= 1:size(I,1)
        for y= 1:size(I,2)
            if I_original(x,y)==0
                if x>end_x
                    end_x=x;
                end
                if x<start_x
                    start_x=x;
                end

                if y>end_y
                    end_y=y;
                end
                if y<start_y
                    start_y=y;
                end
            end
        end
    end
    I=I(start_x:end_x, start_y:end_y);

    %Small region is taken to show output clear
%     figure;imshow(I);title('Input image');impixelinfo

    %Thinning
    I = imcomplement(I);
    thin_image=~bwmorph(I,'thin',inf);
%     figure;imshow(thin_image);title('Thinned Image');impixelinfo;



    %Minutiae extraction
    s=size(thin_image);
    N=3;%window size
    n=(N-1)/2;
    r=s(1)+2*n;
    c=s(2)+2*n;

    bifurcation=zeros(r,c);
    ridge=zeros(r,c);

    double temp(r,c);   
    temp=zeros(r,c);
    temp((n+1):(end-n),(n+1):(end-n))=thin_image(:,:);

    outImg=zeros(r,c,3);%For Display
    outImg(:,:,1) = temp .* 255;
    outImg(:,:,2) = temp .* 255;
    outImg(:,:,3) = temp .* 255;
    
    outImg_ridge = outImg;
    outImg_bif = outImg;

    for x=(n+1+10):(s(1)+n-10)
        for y=(n+1+10):(s(2)+n-10)
            e=1;
            for k=x-n:x+n
                f=1;
                for l=y-n:y+n
                    mat(e,f)=temp(k,l);
                    f=f+1;
                end
                e=e+1;
            end
             if(mat(n+1,n+1)==0)
                ridge(x,y)=sum(sum(~mat));
                bifurcation(x,y)=sum(sum(~mat));
             end
        end
    end
    
%     figure;imshow(ridge);title('Minutiae');impixelinfo;
%     figure;imshow(bifurcation);title('Minutiae');impixelinfo;

    % RIDGE END FINDING
    [ridge_x, ridge_y]=find(ridge==2);
    len=length(ridge_x);
    %For Display
    for x=1:len
        outImg((ridge_x(x)-N):(ridge_x(x)+N),(ridge_y(x)-N),2:3)=0;
        outImg((ridge_x(x)-N):(ridge_x(x)+N),(ridge_y(x)+N),2:3)=0;
        outImg((ridge_x(x)-N),(ridge_y(x)-N):(ridge_y(x)+N),2:3)=0;
        outImg((ridge_x(x)+N),(ridge_y(x)-N):(ridge_y(x)+N),2:3)=0;
        
        outImg_ridge((ridge_x(x)-N):(ridge_x(x)+N),(ridge_y(x)-N),2:3)=0;
        outImg_ridge((ridge_x(x)-N):(ridge_x(x)+N),(ridge_y(x)+N),2:3)=0;
        outImg_ridge((ridge_x(x)-N),(ridge_y(x)-N):(ridge_y(x)+N),2:3)=0;
        outImg_ridge((ridge_x(x)+N),(ridge_y(x)-N):(ridge_y(x)+N),2:3)=0;
    end
    
    %BIFURCATION FINDING
    [bifurcation_x, bifurcation_y]=find(bifurcation==4);
    len=length(bifurcation_x);
    %For Display
    for x=1:len
        outImg((bifurcation_x(x)-N):(bifurcation_x(x)+N),(bifurcation_y(x)-N),1:2)=0;
        outImg((bifurcation_x(x)-N):(bifurcation_x(x)+N),(bifurcation_y(x)+N),1:2)=0;
        outImg((bifurcation_x(x)-N),(bifurcation_y(x)-N):(bifurcation_y(x)+N),1:2)=0;
        outImg((bifurcation_x(x)+N),(bifurcation_y(x)-N):(bifurcation_y(x)+N),1:2)=0;
        
        outImg_bif((bifurcation_x(x)-N):(bifurcation_x(x)+N),(bifurcation_y(x)-N),1:2)=0;
        outImg_bif((bifurcation_x(x)-N):(bifurcation_x(x)+N),(bifurcation_y(x)+N),1:2)=0;
        outImg_bif((bifurcation_x(x)-N),(bifurcation_y(x)-N):(bifurcation_y(x)+N),1:2)=0;
        outImg_bif((bifurcation_x(x)+N),(bifurcation_y(x)-N):(bifurcation_y(x)+N),1:2)=0;
    end
%     figure;imshow(outImg);title('Minutiae');impixelinfo

end

