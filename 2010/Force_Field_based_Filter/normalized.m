function normIm = normalized(I)

mini = min(I(:));
maxi = max(I(:));

I = I - mini;
normIm = I .* (255/(maxi-mini));
normIm = uint8(normIm);