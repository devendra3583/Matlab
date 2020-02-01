This folder contains the codes to extract features from an image I after dividing it into
certain number of sub-images.

/code/Algorithm_2/Project.m
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

FeatureExtraction.m takes an image I and the corresponding direction matrix (obtained from
froce field of I) and performs the following:
1. It divides I into sub-images.
2. For every sub-image, it computes LST matrix for dominant orientation pixels {this is done
with the help of helper functions like anglesTwoPie.m which returns the direction of force 
in range [0, 360], yo90.m which takes the direction matrix of sub-image and distributes 
these orientations among 8 bins. It then finds out the bin with the highest
frequence. It returns exactly those pixels of the sub-image which participate in 
dominant orientation of the sub-image along with the dominant orientation. Thus, the
set D_sub is computed by yo90.m}
3. tensor.m evaluates the mean matrix T_sub and performs eigen decomposition on T_sub.
4. FeatureExtraction.m finally obtains the dominant eigen vector for a sub-image
and is returned as the feature vector for the sub-image. A concatenation of these
individual feature vectors is done to obtain the feature matrix for the entire
image I which is then returned.