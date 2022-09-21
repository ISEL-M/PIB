function equal = exercicio3_c(I1,I2)
    if nargin < 2
        I1 = 'test.bmp';
        I2 = 'test.bmp';
    end
    
    equal = false;
    
    I_original = imread(I1);
    I2 = imread(I2);
%     temp = ones(size(I2,1),1)*5;
%     I2 = cat(2,I2(:,end-1),I2(:,2:end-1));
    
    [ridge_original, bifurcation_original] = exercicio3_b(I_original);
    [ridge2, bifurcation2] = exercicio3_b(I2);
    
    [ridge_original_x, ridge_original_y] = find(ridge_original == 2);
    [ridge2_x, ridge2_y] = find(ridge2 == 2);
    
    [bifurcation_original_x, bifurcation_original_y] = find(bifurcation_original == 4);
    [bifurcation2_x, bifurcation2_y] = find(bifurcation2 == 4);
    
    a=length(ridge2_x)/length(ridge_original_x);
    if a==1 || 1/a==1
        comp_ridge_x = abs(ridge_original_x(1)-ridge2_x(1));
        comp_ridge_y = abs(ridge_original_y(1)-ridge2_y(1));
        comp_bif_x = abs(bifurcation_original_x(1)-bifurcation2_x(1));
        comp_bif_y = abs(bifurcation_original_y(1)-bifurcation2_y(1));
        
        for i = 1:length(ridge_original_x)
            dif_x = abs(ridge_original_x(i)-ridge2_x(i));
            dif_y = abs(ridge_original_y(i)-ridge2_y(i));
            
            prox_x = dif_x/comp_ridge_x;
            prox_y = dif_y/comp_ridge_y;
            if prox_x~=1 && 1/prox_x~=1 || prox_y~=1 && 1/prox_y~=1
                return
            end
        end
        
        for i = 1:length(bifurcation_original_x)
            dif_x = abs(bifurcation_original_x(i)-bifurcation2_x(i));
            dif_y = abs(bifurcation_original_y(i)-bifurcation2_y(i));
            
            prox_x = dif_x/comp_bif_x;
            prox_y = dif_y/comp_bif_y;
            if prox_x~=1 && 1/prox_x~=1 || prox_y~=1 && 1/prox_y~=1
                return
            end
        end
    end
    
    
    equal = true;
    
end

