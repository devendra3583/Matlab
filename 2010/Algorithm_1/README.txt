This folder contains the codes to extract features from an image I after dividing it into
certain number of sub-images.

/code/Algorithm_1/Project.m
The database images are first divided into 2 sets: 
(1). Training Set, and
(2). Testing Set
Project.m computes the features from images and stores them into Fea_trn
 and Fea_tst respectively.
It then calls Verify_Bin on Fea_trn and Fea_tst to obtain the matching scores between 
each image of Fea_tst with each image of Fea_trn.

Verify_Bin.m computes the matching scores and enters the score into Same.txt if the score
is between images of the same subject or puts the score value into Diff.txt otherwise.

Project.m finally calls test.m which plots FAR and FRR curves using Same.txt and Diff.txt

FeatureExtraction.m divides the image I into sub-images and computes T_sub for every subimage and then the
dominant eigen vector which is stored as feature vector for the sub-image. Concatenation of individual 
f.v.s of sub-image is done to obtain feature matrix for the entire image I which is then stored into Fea_trn
or Fea_tst as the case may be.
