%%%http://www.cs.cmu.edu/~sarsen/structureTensorTutorial/
function [e1, e2, l1, l2, coherenceI] = tensor(img)
    img = double(img);

    [rows, cols] = size(img);

 

%         subplot(121);
% 
%         imagesc(img); %-------- visual
% 
%         axis xy;
% 
%         axis tight;
% 
%         axis square;
% 
%         colormap gray;
% 
%         title('Original Image');

 

    maskSize = max([rows, cols]);

    % midpt = ceil(maskSize/2);

    DoG = difference_of_gaussian_kernels(maskSize);

 

    Ix = conv2(img, DoG.Gx,'same');

    Iy = conv2(img, DoG.Gy,'same');

    
    fxSqr = Ix .* Ix;
    fxfy = Ix .* Iy;
    fySqr = Iy .* Iy;
    
    %% Mean values of fxSqr, fxy, fySqr
    IxIx = mean(fxSqr(:));
    IxIy = mean(fxfy(:));
    IyIy = mean(fySqr(:));
    
    
    MI = [IxIx, IxIy;...

          IxIy, IyIy]; %--- structure tensor for 'I'sotropic case
    
    %  
% 
%     DD_mag = sqrt(Ix.^2 + Iy.^2);
% 
%     DD_mag = DD_mag./255;   %---------- grayscale [0,255] --> [0,1]
% 
%     DD_phase = atan2(Iy, Ix);
% 
%     [U,V] = pol2cart(DD_phase, DD_mag);
% 
%     cU = U(midpt, midpt);
% 
%     cV = V(midpt, midpt);
% 
%     cDD_mag = DD_mag(midpt, midpt);
% 
%     cDD_phase = DD_phase(midpt, midpt)*(180/pi);  %---- convert to degrees

 

%         subplot(122);
% 
%         imagesc(img); %-------- visual
% 
%         axis xy;
% 
%         axis tight;
% 
%         axis square;
% 
%         colormap gray;
% 
%         hold on;
% 
%         quiver(midpt, midpt, cU, cV, midpt, 'r', 'LineWidth', 5, 'MaxHeadSize', 5);
% 
%         tmsg = sprintf('Directional Derivative (Mag=%.2f, Phase=%.0f)', cDD_mag, cDD_phase);
% 
%         title(tmsg);


% IxI = Ix(midpt, midpt);             % --------- used in structure tensor code
% 
% IyI = Iy(midpt, midpt);
% % subplot(1,1,1);
% 
% %     cla;
% % 
% %     axis off;
% 
%  
% 
%     MI = [IxI*IxI, IxI*IyI;...
% 
%           IxI*IyI, IyI*IyI]; %--- structure tensor for 'I'sotropic case

%     MU = [IxU*IxU, IxU*IyU;...
% 
%           IxU*IyU, IyU*IyU];  %--- structure tensor for 'U'niform case

 

    [e1,e2,l1,l2] = eigen_decomposition(MI);

    if (l1+l2) > 0

        coherenceI = ((l1-l2)/(l1+l2))^2;

    else

        coherenceI = 0;

    end
%     close all;