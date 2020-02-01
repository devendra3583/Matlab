
Trn_Pth = 'J:\Dev\PolyU_trn\*.bmp';

Tst_Pth = 'J:\Dev\PolyU_tst\*.bmp';

tic;

Trn = dir(Trn_Pth);
Tst = dir(Tst_Pth);
Pth = 'J:\Dev\Fea_trn\';
display('Training started');
for i = 1 : size(Trn);
    
    fname  = strcat(strtok(Trn_Pth,'*'),Trn(i).name);
    im = imread(fname);
    Feature = FeatureExtraction(im);  % Call u r routine
    fname = strcat(Pth,'/', strtok(Trn(i).name,'.'),'.dat');
    dlmwrite(fname,Feature);
    
end
display('Training done');

Pth = 'J:\Dev\Fea_tst\';
display('Testing started');
for i = 1 : size(Tst);

    fname  = strcat(strtok(Tst_Pth,'*'),Tst(i).name);
    im = imread(fname);
    Feature = FeatureExtraction(im);  % Call u r routine
    fname = strcat(Pth,'/', strtok(Tst(i).name,'.'),'.dat');
    dlmwrite(fname,Feature);
    
end
display('Testing done');
Verify_Bin( '.\Fea_trn\', '.\Fea_tst\');
test;

disp('Project Done');
toc;


