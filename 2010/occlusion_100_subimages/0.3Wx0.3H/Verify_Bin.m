
function Verify_Bin( Bin_Trn, Bin_Tst)
clc;
close all;

Cmp_Sze  = 10;
RRR = 80;
CCC = 4;
Type = 'double';
close all;
clear dist;

    Trn_pth = Bin_Trn;
    Tst_pth = Bin_Tst;

    Trn_Fle = dir(strcat(Trn_pth,'*.dat'));
    Tst_Fle = dir(strcat(Tst_pth,'*.dat'));
    
    Trn_NFiles = size(Trn_Fle,1);
    Tst_NFiles = size(Tst_Fle,1);

    Res_File = strcat('.\Result\Same.txt');
    fp = fopen(Res_File,'w');

    Res_File = strcat('.\Result\Diff.txt');
    fp1 = fopen(Res_File,'w');
    
    for_identification = strcat('.\Result\Score.txt');
    fi = fopen(for_identification,'w');
    % Score.txt stores scores as:
    % Tst Trn Score

    Tot_Matches = 0;
    Tot_Match = 0;
    N_Match = 0;
    Match_Time = 0;
    p = pwd;
    tic
    for j = 1 : Tst_NFiles
        
        clear fname1;
        fname1 = strcat(Tst_pth,Tst_Fle(j).name);
        Tst_Im = dlmread(fname1);
        Tst_Im(1) = 0; 
        Tst_Im(2) = 0;
        Tst_Im(3) = 0;
        Tst_Im(4) = 0;
        Tst_Im(5) = 0;
        Tst_Im(6) = 0;
%         Tst_Im(7) = 0;
%         Tst_Im(8) = 0;
%         Tst_Im(9) = 0;
%         Tst_Im(10) = 0;
%         
        Tst_Im(21) = 0; 
        Tst_Im(22) = 0;
        Tst_Im(23) = 0;
        Tst_Im(24) = 0;
        Tst_Im(25) = 0;
        Tst_Im(26) = 0;
%         Tst_Im(27) = 0;
%         Tst_Im(28) = 0;
%         Tst_Im(29) = 0;
%         Tst_Im(30) = 0;
        
        Tst_Im(41) = 0; 
        Tst_Im(42) = 0;
        Tst_Im(43) = 0;
        Tst_Im(44) = 0;
        Tst_Im(45) = 0;
        Tst_Im(46) = 0;
%         Tst_Im(47) = 0;
%         Tst_Im(48) = 0;
%         Tst_Im(49) = 0;
%         Tst_Im(50) = 0;
%         
        
        Prv_Dist = inf;
        Prev_Fname = Trn_Fle(1).name;

        for i = 1 : Trn_NFiles
			clear fname2;
            fname2 = strcat(Trn_pth, Trn_Fle(i).name);
			Trn_Im = dlmread(fname2);
            Trn_Im(1) = 0; 
        Trn_Im(2) = 0;
        Trn_Im(3) = 0;
        Trn_Im(4) = 0;
        Trn_Im(5) = 0;
        Trn_Im(6) = 0;
%         Trn_Im(7) = 0;
%         Trn_Im(8) = 0;
        
        Trn_Im(21) = 0; 
        Trn_Im(22) = 0;
        Trn_Im(23) = 0;
        Trn_Im(24) = 0;
        Trn_Im(25) = 0;
        Trn_Im(26) = 0;
%         Trn_Im(27) = 0;
%         Trn_Im(28) = 0;
        
        
        Trn_Im(31) = 0; 
        Trn_Im(32) = 0;
        Trn_Im(33) = 0;
        Trn_Im(34) = 0;
        Trn_Im(35) = 0;
        Trn_Im(36) = 0;
%        Trn_Im(37) = 0;
 %       Trn_Im(38) = 0;
        
        
            Score = classifier(Trn_Im , Tst_Im);
            fprintf(fi,'%f \t %f \t %f \n',j,i,Score);
                       
            if ( strncmp(Prev_Fname, Trn_Fle(i).name, Cmp_Sze) )
            
                Dist = Score;
                Prv_Dist = min(Dist, Prv_Dist);
                Prev_Fname = Trn_Fle(i).name;
             else
                 if( strncmp(Prev_Fname, Tst_Fle(j).name, Cmp_Sze) )     % 10 for PolyU 7 for IITK
                     fprintf(fp,'%f \t %f \t %f \n',Prv_Dist, Prv_Dist/(RRR * CCC), j);
                else
                     fprintf(fp1,'%f \t %f \t %f \n',Prv_Dist, Prv_Dist/(RRR * CCC), j);
                end
                Prv_Dist = Score;
                Prev_Fname = Trn_Fle(i).name;
            end
         end
        
        
        if( strncmp(Prev_Fname, Tst_Fle(j).name, Cmp_Sze) )     % 10 for PolyU 7 for IITK
                     fprintf(fp,'%f \t %f \t %f \n',Prv_Dist, Prv_Dist/(RRR * CCC), j);
        else
                     fprintf(fp1,'%f \t %f \t %f \n',Prv_Dist, Prv_Dist/(RRR * CCC), j);
        end
    end
    
    Mat_Time = toc;
    
fclose all;
    
