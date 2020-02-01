function deg = anglesTwoPie(rad)
deg = rad .* 180 / pi;
[r,c] = size(rad);
for i=1:r
    for j=1:c
        if(deg(i,j) < 0)
            deg(i,j) = deg(i,j) + 360;
        end;
    end;
end;