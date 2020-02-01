% clear all;
% close all;
% clc;


Trn_Pth = 'J:\Dev\casia_entire_db_sorted\CASIA_Trn\*.jpg';
%Trn_Pth_orient = 'J:\Dev\Filtered\15_orient\Trn_orient\*.dat';
Trn_Pth_orient = 'J:\Dev\dominant_orientation_entire_casia_db\11_trn\*.dat';
Tst_Pth = 'J:\Dev\casia_entire_db_sorted\CASIA_Tst\*.jpg';
Tst_Pth_orient = 'J:\Dev\dominant_orientation_entire_casia_db\11_tst\*.dat';



Trn = dir(Trn_Pth);
Trn_orient = dir(Trn_Pth_orient);
Tst = dir(Tst_Pth);
Tst_orient = dir(Tst_Pth_orient);
Pth = 'J:\Dev\Fea_trn\';
display('Training started');
for i = 1 : size(Trn);
    
    fname  = strcat(strtok(Trn_Pth,'*'),Trn(i).name);
    im = imread(fname);
    fname_orient = strcat(strtok(Trn_Pth_orient,'*'),Trn_orient(i).name);
    mat = dlmread(fname_orient);
    Feature = FeatureExtraction(im(1:255,1:255), mat);  % Call u r routine
    fname = strcat(Pth,'/', strtok(Trn(i).name,'.'),'.dat');
    dlmwrite(fname,Feature);
    
end
display('Training done');

Pth = 'J:\Dev\Fea_tst\';
display('Testing started');
for i = 1 : size(Tst);

    fname  = strcat(strtok(Tst_Pth,'*'),Tst(i).name);
    im = imread(fname);
    fname_orient = strcat(strtok(Tst_Pth_orient,'*'),Tst_orient(i).name);
    mat = dlmread(fname_orient);
    Feature = FeatureExtraction(im(1:255,1:255), mat);  % Call u r routine
    fname = strcat(Pth,'/', strtok(Tst(i).name,'.'),'.dat');
    dlmwrite(fname,Feature);
    
end
display('Testing done');
Verify_Bin( '.\Fea_trn\', '.\Fea_tst\');
test;

disp('Project Done');
toc;


