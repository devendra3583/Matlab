
Trn_Pth_orient = 'J:\Dev\casia_entire_db_sorted\CASIA_Trn\*.jpg';


Tst_Pth_orient = 'J:\Dev\casia_entire_db_sorted\CASIA_Tst\*.jpg';

tic;

kernel = 11;

Trn = dir(Trn_Pth_orient);

Tst = dir(Tst_Pth_orient);

display('Training started');
Pth_trn = 'J:\Dev\dominant_orientation_entire_casia_db\11_trn';
Pth_tst = 'J:\Dev\dominant_orientation_entire_casia_db\11_tst';
for i = 1 :2: size(Trn);
    
    fname  = strcat(strtok(Trn_Pth_orient,'*'),Trn(i).name);
    im = imread(fname);
    [X, Y] = ForceFieldFilter(im(1:255,1:255),kernel); 
    deg_pi = atan2(Y,X);
    deg = anglesTwoPie(deg_pi);
    mat = deg;
    
    fname = strcat(Pth_trn,'/', strtok(Trn(i).name,'.'),'_.dat');
    dlmwrite(fname,mat);
    fname = strcat(Pth_trn,'/', strtok(Trn(i+1).name,'.'),'_.dat');
    dlmwrite(fname,mat);
    j = floor(i/2);
    k = j*6;
    fname1 = strcat(Pth_tst,'/', strtok(Tst(k+1).name,'.'),'_.dat');
    fname2 = strcat(Pth_tst,'/', strtok(Tst(k+2).name,'.'),'_.dat');
    fname3 = strcat(Pth_tst,'/', strtok(Tst(k+3).name,'.'),'_.dat');
    fname4 = strcat(Pth_tst,'/', strtok(Tst(k+4).name,'.'),'_.dat');
    fname5 = strcat(Pth_tst,'/', strtok(Tst(k+5).name,'.'),'_.dat');
    fname6 = strcat(Pth_tst,'/', strtok(Tst(k+6).name,'.'),'_.dat');
    %fname7 = strcat(Pth_tst,'/', strtok(Tst(k+7).name,'.'),'_.dat');
    %fname8 = strcat(Pth_tst,'/', strtok(Tst(k+8).name,'.'),'_.dat');
    dlmwrite(fname1,mat);
    dlmwrite(fname2,mat);
    dlmwrite(fname3,mat);
    dlmwrite(fname4,mat);
    dlmwrite(fname5,mat);
    dlmwrite(fname6,mat);
    %dlmwrite(fname7,mat);
    %dlmwrite(fname8,mat);
end
Project_casia();
