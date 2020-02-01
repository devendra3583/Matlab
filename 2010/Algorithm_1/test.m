function test

close all;
clear all;
clc;


[Ac5  ERR_5 fr Frr_100 Frr_1000 Frr_10000 fa Far_100 Far_1000 Far_10000 t] = graph();
sprintf('Accuracy = %d',Ac5)
sprintf('Equal Error Rate = %d',ERR_5)
% sprintf('FRR @ 1/100*FAR = %d',Frr_100)
% sprintf('FRR @ 1/1000*FAR= %d',Frr_1000)
% sprintf('FAR @ 1/100*FRR= %d',Far_100)
% sprintf('FAR @ 1/1000*FRR= %d',Far_1000)

figure; plot(t,fa,t,fr);
legend('FAR','FRR');
xlabel('Threshold');
ylabel('Error Rate');



disp('Done');


function[Acc ERR fr Frr_100 Frr_1000 Frr_10000 fa Far_100 Far_1000 Far_10000 t] =  graph()

                
            ss = strcat('.\Result\Same.txt');
            dd = strcat('.\Result\Diff.txt');
                
            ss
                    [same B B1 B2 B4]=textread(ss,'%f\t%f\t%f\t%f\t%f');
                    [diff D D1 D2 D4]=textread(dd,'%f\t%f\t%f\t%f\t%f');
                    
                    New_Same = [same B1];
                    Srt_sme = sortrows(New_Same,2);
                    New_Diff = [diff D1];
                    Srt_Dif = sortrows(New_Diff,2);
                    [Ind1 r1 c1] =  unique(D1,'first');
                    [Ind2 r2 c2] =  unique(B1,'first');
                    
                    yy = Srt_Dif(r1); 
                    yy1 = Srt_sme(r2,1);
                    res = ( sum( yy1 < yy)  ) / size(yy1,1) * 100;
                    
                    maxthresh=max(max(same(:)),max(diff(:)));
                    th = (min(yy) - max(yy1))/maxthresh;

                    inc = 0.0;
                    [a1 fa ga fr t] = accuracy1(same,diff,inc);
                    h = semilogx(fa,fr);
                    xlabel('FAR');
                    ylabel('FRR');

                    
                    Acc = res;
                    ERR = comp_Err(fa,fr);
                    Frr_100 = comp_Frr(fa,fr, 1/100);
                    Frr_1000 = comp_Frr(fa,fr, 1/1000);
                    Frr_10000 = comp_Frr(fa,fr, 1/10000);
                    Far_100  = comp_Far(fa,fr, 1/100);
                    Far_1000  = comp_Far(fa,fr, 1/1000);
                    Far_10000 = comp_Far(fa,fr, 1/10000);
                    
                    
               
function[ERR] = comp_Err(Far,Frr)


for i = 1 : size(Far,2)
    
    if ( Far(i) >= Frr(i) )
        
        ERR = Far(i);
        break;
        
    end
    
end


function[FRR] = comp_Frr(Far,Frr, Th)


for i = 1 : size(Far,2)
    
    if ( Far(i) >= Th )
        
        FRR = Far(i);
        break;
        
    end
    
end


function[FAR] = comp_Far(Far,Frr, Th)


flag = 0;
for i = 1 : size(Far,2)
    
    if ( Frr(i) <= Th )
        
        FAR = Frr(i);
        flag = 1;
        break;
        
    end
    
end

if ( flag == 0)
    FAR = Far(i);
end





function[acc_sift far gar frr t]= accuracy1(same,diff,inc)



i=1;

minthresh = min(min(same(:)),min(diff(:)));
maxthresh=max(max(same(:)),max(diff(:)));

if( maxthresh == inf)
    disp('Infinity');
     return;
end
   

same = same / maxthresh;
diff = diff/ maxthresh;


if(maxthresh == Inf )
    
    indices = find(diff ~= Inf);
    maxthresh  = max(diff(indices));
end



if( minthresh < 0)
    minthresh = 0;
end
    

for thresh=0: 0.0001 :1
    %% count number of values greater than thresh and compute the
    %% percentage
    frr(i)=(sum(same>thresh)/size(same,1))*100;
    
    far(i)=(sum(diff<=thresh)/size(diff,1))*100;
    acc(i)=100-((far(i)+frr(i))/2);
    gar(i)=100-frr(i);
    
    t(i)=thresh;
    i=i+1;
end







[acc_sift tg]=max(acc);
