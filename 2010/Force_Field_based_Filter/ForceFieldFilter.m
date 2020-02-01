function [FF_Fil_Im_X, FF_Fil_Im_Y] = ForceFieldFilter(I,ker)

kernel = ker - 1;
%originalIm = I;
%%% Kernel = 2^x

% imshow(I, []);
I = double(I);



%values = zeros(num_rows, num_columns); %values(i,j) stores the sum of F over n x n nbrhood for (i,j)
%valuesNormalized = zeros(num_rows, num_columns);  %Normalized values in range [0,255]
%detect = zeros(num_rows, num_columns); %stores 1 if a point 
% (pixel value i.e. (i,j) qualifies for a genuine keyPoint

kernelby2 = kernel/2;
%FF_Fil_Im(:,:)  = blkproc(I,[1 1],[kernelby2 kernelby2],@myfunblock);  %% Force Field Filter
FF_Fil_Im_X(:,:) = blkproc(I,[1 1],[kernelby2 kernelby2],@myfunblock_X);
FF_Fil_Im_Y(:,:) = blkproc(I,[1 1],[kernelby2 kernelby2],@myfunblock_Y);

%Norm_Im = normalized(FF_Fil_Im(:,:)); %Normalized Image in uint8





% figure; imshow(FF_Fil_Im, []);
%detect(:,:) = blkproc(FF_Fil_Im,[1 1],[kernelby2 kernelby2],@funblock); %% Detect keyPoints
% disp(detect, I, kernelby2);
% 
% 
% 
% function disp(Keys, Orig_Im, kernelby2)
% figure; imshow(Orig_Im, []);
% [num_rows, num_columns] = size(Orig_Im); %dimensions of image
% l = num_rows - kernelby2;
% m = num_columns - kernelby2;
% 
% %         [r c] = find(Keys);
% %         plot(r, c ,'*');
% % 
% hold on;
%  for j = (kernelby2 + 1):l
%          for k = (kernelby2 + 1):m
% 
% %  for j = 1:num_rows
% %          for k  = 1:num_columns
%              if (Keys(j,k) == 1)
%                  plot(j,k,'*y');
%              end;
%          end;
%  end;
%  hold off;


%          
%          


% Newton's law of universal gravitation states that every massive particle in the universe attracts every other 
% massive particle with a force which is directly proportional to the product of their masses and inversely 
% proportional to the square of the distance between them
% 
% 
% Using
% 1.	Newton’s Law of universal gravitation, and
% 2.	(Bitwise xor instead of product in (1.) we here propose a novel filter which distinguishes between white 
% regions, black regions and mixed regions with a high discriminating
% accuracy)xxx   Product only.
% 

% For (kernel + 1) x (kernel + 1) sub-image


% novel filter
% for j = (kernelby2+1):l
%          for k = (kernelby2+1):m
%              sumtemp = 0;
%              pixelvalue = I(j,k);
%              for p = j-kernelby2:j+kernelby2
%                  for q = k-kernelby2:k+kernelby2
%                      if((j==p) && (k==q))   %Make sure 0 is not in denominator
%                          continue;
%                      end;
%                      tmp = I(p,q);
%                      rsqr = (j-p)^2 + (k-q)^2;
%                      % F = bitxor(pixelvalue,tmp)/rsqr;
%                      F = (pixelvalue * tmp)/rsqr;
%                      sumtemp = sumtemp + F;
%                  end;
%              end;
%              values(j,k) = sumtemp;
%          end;
% end;



%myfun = @(x) max(x(:));


function [val] = myfunblock(I)
    [r, c] = size(I);
    centralPixelVal = I(ceil(r/2),ceil(c/2));
    I1 = I .* centralPixelVal; %Product of two pixel values 
    x = ceil(r/2); %% (x,y) is the position vector of central pixel
    y = ceil(c/2);
    direction_X = zeros(r, c);
    direction_Y = zeros(r, c);
    mat = zeros(r, c);
    Force_X = zeros(r, c); % Force_X(i,j) holds the x-component of Force on pixel (x,y) due to pixel (i,j)
    Force_Y = zeros(r, c);
    
    
    for i=1:r
        for j=1:c %% (i,j) is the position vector of pixel P(i,j)
            direction_X(i,j) = (i-x); %% stores x-component of Force Vector
            direction_Y(i,j) = (j-y); %% stores y-component of Force Vector
            mat(i,j) = ((i-x)^2 + (j-y)^2 )^(1.5) + eps;
            % Force_X(i,j) holds the x-component of Force on pixel (x,y)
            % due to pixel (i,j)
            Force_X(i,j) = I1(i,j) * direction_X(i,j) / mat(i,j);
            Force_Y(i,j) = I1(i,j) * direction_Y(i,j) / mat(i,j);
            % Force_Y(i,j) holds the y-component of Force on pixel (x,y)
            % due to pixel (i,j)
        end;
    end;
    
    Force_X(x,y) = 0; % Force on central pixel (x,y) due to itself = 0
    Force_Y(x,y) = 0;
    val_X = sum(Force_X(:)); 
    % x-component of the Resultant Force on pixel (x,y) due to all the
    % pixels in kernel x kernel
    val_Y = sum(Force_Y(:)); 
    % x-component of the Resultant Force on pixel (x,y) due to all the
    % pixels in kernel x kernel
    
    val =  ((val_X)^2 + (val_Y)^2) ^ (0.5); 
    % Magnitude of the Resultant Force vector on pixel (x,y) due to all the
    % pixels in kernel x kernel
    

function [val_X] = myfunblock_X(I)
    [r, c] = size(I);
    centralPixelVal = I(ceil(r/2),ceil(c/2));
    I1 = I .* centralPixelVal; %Product of two pixel values 
    x = ceil(r/2); %% (x,y) is the position vector of central pixel
    y = ceil(c/2);
    direction_X = zeros(r, c);
    direction_Y = zeros(r, c);
    mat = zeros(r, c);
    Force_X = zeros(r, c); % Force_X(i,j) holds the x-component of Force on pixel (x,y) due to pixel (i,j)
    %Force_Y = zeros(r, c);
    
    
    for i=1:r
        for j=1:c %% (i,j) is the position vector of pixel P(i,j)
            direction_X(i,j) = (i-x); %% stores x-component of Force Vector
            direction_Y(i,j) = (j-y); %% stores y-component of Force Vector
            mat(i,j) = ((i-x)^2 + (j-y)^2 )^(1.5) + eps;
            % Force_X(i,j) holds the x-component of Force on pixel (x,y)
            % due to pixel (i,j)
            Force_X(i,j) = I1(i,j) * direction_X(i,j) / mat(i,j);
            %Force_Y(i,j) = I1(i,j) * direction_Y(i,j) / mat(i,j);
            % Force_Y(i,j) holds the y-component of Force on pixel (x,y)
            % due to pixel (i,j)
        end;
    end;
    
    Force_X(x,y) = 0; % Force on central pixel (x,y) due to itself = 0
    %Force_Y(x,y) = 0;
    val_X = sum(Force_X(:)); 
    % x-component of the Resultant Force on pixel (x,y) due to all the
    % pixels in kernel x kernel
    %val_Y = sum(Force_Y(:)); 
    % x-component of the Resultant Force on pixel (x,y) due to all the
    % pixels in kernel x kernel
    
    %val =  ((val_X)^2 + (val_Y)^2) ^ (0.5); 
    % Magnitude of the Resultant Force vector on pixel (x,y) due to all the
    % pixels in kernel x kernel
    
    
    function [val_Y] = myfunblock_Y(I)
    [r, c] = size(I);
    centralPixelVal = I(ceil(r/2),ceil(c/2));
    I1 = I .* centralPixelVal; %Product of two pixel values 
    x = ceil(r/2); %% (x,y) is the position vector of central pixel
    y = ceil(c/2);
    direction_X = zeros(r, c);
    direction_Y = zeros(r, c);
    mat = zeros(r, c);
    %Force_X = zeros(r, c); % Force_X(i,j) holds the x-component of Force on pixel (x,y) due to pixel (i,j)
    Force_Y = zeros(r, c);
    
    
    for i=1:r
        for j=1:c %% (i,j) is the position vector of pixel P(i,j)
            direction_X(i,j) = (i-x); %% stores x-component of Force Vector
            direction_Y(i,j) = (j-y); %% stores y-component of Force Vector
            mat(i,j) = ((i-x)^2 + (j-y)^2 )^(1.5) + eps;
            % Force_X(i,j) holds the x-component of Force on pixel (x,y)
            % due to pixel (i,j)
            %Force_X(i,j) = I1(i,j) * direction_X(i,j) / mat(i,j);
            Force_Y(i,j) = I1(i,j) * direction_Y(i,j) / mat(i,j);
            % Force_Y(i,j) holds the y-component of Force on pixel (x,y)
            % due to pixel (i,j)
        end;
    end;
    
    %sForce_X(x,y) = 0; % Force on central pixel (x,y) due to itself = 0
    Force_Y(x,y) = 0;
    %sval_X = sum(Force_X(:)); 
    % x-component of the Resultant Force on pixel (x,y) due to all the
    % pixels in kernel x kernel
    val_Y = sum(Force_Y(:)); 
    % x-component of the Resultant Force on pixel (x,y) due to all the
    % pixels in kernel x kernel
    
    %val =  ((val_X)^2 + (val_Y)^2) ^ (0.5); 
    % Magnitude of the Resultant Force vector on pixel (x,y) due to all the
    % pixels in kernel x kernel




% % Normalize values(i,j) in range [0,255]
% maxi = max (max(values));
% mini = min (min(values));
% diff = maxi - mini;
% 
% valuesNormalized = originalIm;
% 
% for j = (kernelby2 + 1):l
%          for k = (kernelby2 + 1):m
%              valuesNormalized(j,k) = (values(j,k) - mini)  * 255/diff ;
%          end;
% end;
% figure; imshow(valuesNormalized, [0 255]);



% Keypoint detection

%%% Seeing maxima in (kernel+1) x (kernel+1) w.r.t. keypoint as centre
% fun = @(x) max(x(:));
% N1(:,:) = blkproc(valuesNormalized(:,:),[1 1],[kernelby2 kernelby2],fun);
% for j = (kernelby2 + 1):l
%          for k = (kernelby2 + 1):m
%              if (valuesNormalized(j,k) == N1(j,k)) 
%                  detect(j,k) = 1;
%              end;
%          end;
% end;



function Res = funblock(FF_Fil) %% To detect keypoint (returns 0 or 1)

    Res = 0;
    [r, c] = size(FF_Fil);
    Mx = max(FF_Fil(:));
    Mn = min(FF_Fil(:));
    x = ceil(r/2);
    y = ceil(c/2);
    if ((FF_Fil(x,y) == Mx) || (FF_Fil(x,y) == Mn))
        Res = 1;
    end;

    
    
%     function out_Im = normalized(FF_Fil_Im)
%         maxi = max(FF_Fil_Im(:));
%         mini = min(FF_Fil_Im(:));
%         diff = maxi - mini;
%         [r, c] = size(FF_Fil_Im);
%         out_Im = zeros(r,c);
%         for i=1:r
%             for j=1:c
%                 out_Im(i,j) = (out_Im(i,j) - mini)/diff * 255;
%             end;
%         end;
% 
