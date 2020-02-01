function [val,accuracy] = aa(fa, fr)
accuracy = 100 - ((fa(1)+fr(1))/2);
for i = 2:size(fa,2)
    acc = 100 - ((fa(i)+fr(i))/2);
    if (acc > accuracy)
        accuracy = acc;
        val = i;
    end;
end;