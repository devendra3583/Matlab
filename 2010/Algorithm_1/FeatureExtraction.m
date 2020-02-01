function [fv] = FeatureExtraction(I)
%J = zeros(204,204);
%J(1:201,1:201) = I;
Im = imresize(I, [200 200]);
%Im = I(1:196,1:196);
fv = [];
E = [];
%Tmp = [];
F=[];
C = mat2cell(Im,[50 50 50 50], [50 50 50 50]);
for v=1:4
    Tmp = [];
    for k=1:4
    [e1, e2, l1, l2, coherenceI] = tensor(C{v,k});
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
