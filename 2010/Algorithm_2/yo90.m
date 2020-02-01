function [detect,domOrient] = yo90(deg)
%% Takes a matrix as input and returns those pixels that belong to dominant
%% orientation bin
[r,c] = size(deg);


detect = zeros(r, c);
mini = min(deg(:));
maxi = max(deg(:));
%% 8 bins
diff = maxi - mini;
diff8 = diff/8;
bin_1 = mini + diff8;
bin_2 = mini + (2 *diff8);
bin_3 = mini + (3 *diff8);
bin_4 = mini + (4 *diff8);
bin_5 = mini + (5 *diff8);
bin_6 = mini + (6 *diff8);
bin_7 = mini + (7 *diff8);


%% Bin 1: mini <= theta <= bin_1
detect1 = zeros(r,c); %It has a '1' entry if correspoding orientation participates in dom. orientation

        for i=1:r
            for j=1:c
                if((deg(i,j) >= mini) && (deg(i,j) <= bin_1)) 
                   detect1(i,j) = 1;
                end;
            end;
        end;
%% Bin 2
detect2 = zeros(r,c); 

        for i=1:r
            for j=1:c
                if((deg(i,j) > bin_1) && (deg(i,j) <= bin_2)) 
                   detect2(i,j) = 1;
                end;
            end;
        end;
%% Bin 3
detect3 = zeros(r,c); 

        for i=1:r
            for j=1:c
                if((deg(i,j) > bin_2) && (deg(i,j) <= bin_3)) 
                   detect3(i,j) = 1;
                end;
            end;
        end;
%% Bin 4
detect4 = zeros(r,c); 

        for i=1:r
            for j=1:c
                if((deg(i,j) > bin_3) && (deg(i,j) <= bin_4)) 
                   detect4(i,j) = 1;
                end;
            end;
        end;
%% Bin 5
detect5 = zeros(r,c); 

        for i=1:r
            for j=1:c
                if((deg(i,j) > bin_4) && (deg(i,j) <= bin_5)) 
                   detect5(i,j) = 1;
                end;
            end;
        end;
%% Bin 6
        detect6 = zeros(r,c); 
       
        for i=1:r
            for j=1:c
                if((deg(i,j) > bin_5) && (deg(i,j) <= bin_6)) 
                   detect6(i,j) = 1;
                end;
            end;
        end;
    %% Bin 7
    detect7 = zeros(r,c); 
       
        for i=1:r
            for j=1:c
                if((deg(i,j) > bin_6) && (deg(i,j) <= bin_7)) 
                   detect7(i,j) = 1;
                end;
            end;
        end;
%% Bin 8
detect8 = zeros(r,c); 
   
        for i=1:r
            for j=1:c
                if((deg(i,j) > bin_7) && (deg(i,j) <= maxi)) 
                   detect8(i,j) = 1;
                end;
            end;
        end;

        vect = [sum(detect1(:)) sum(detect2(:)) sum(detect3(:)) sum(detect4(:))];
        [v_sort, i_sort] = sort(vect, 'descend');
%%       
switch(i_sort(1))
    case 1
        domOrient = (mini + bin_1)/2;
        detect = detect1;
    case 2
        domOrient = (bin_1 + bin_2)/2;
        detect = detect2;
    case 3
        domOrient = (bin_2 + bin_3)/2;
        detect = detect3;
    case 4
        domOrient = (bin_3 + bin_4)/2;
        detect = detect4;
    case 5
        domOrient = (bin_4 + bin_5)/2;
        detect = detect5;
    case 6
        domOrient = (bin_5 + bin_6)/2;
        detect = detect6;
    case 7
        domOrient = (bin_6 + bin_7)/2;
        detect = detect7;
    case 8
        domOrient = (bin_7 + maxi)/2;
        detect = detect8;
end;
    