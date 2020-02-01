function [fv] = FeatureExtraction(I, mat)
%J = zeros(204,204);
%J(1:201,1:201) = I;
%Im = imresize(I, [200 200]);
%Im = I(1:196,1:196);
fv = [];
E = [];
%Tmp = [];
F=[];
C = mat2cell(I,[11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 2], [11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 2]);
M = mat2cell(mat,[11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 2], [11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 2]);
for v=1:23
    Tmp = [];
    for k=1:23
        [detect, domO] = yo90(M{v,k});
    [e1, e2, l1, l2, coherenceI] = tensor(C{v,k}, detect);
    % tensor returns eigen basis (mean value for all 16x16 pixels of the
    % subimage 
    if(l1 > l2)
          E = e1';
      else
          E = e2';
      
    end;
    Tmp = [Tmp E];
    
    end
    fv = [fv ; Tmp];
end
