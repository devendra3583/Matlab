% function[res] = classifier(fst, snd)
% 
% res = abs(fst - snd);
% res = (res.^2);
% res = sum(res(:));
% 
function[res] = classifier(fst, snd)

[r c] = size(fst);
HC = (fst - snd).^2;
res = (sum(HC(:))).^0.5;
 
 