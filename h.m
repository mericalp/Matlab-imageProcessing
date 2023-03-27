clc; 
clear;
LI1= imread ('DATA2/person_008_db2_L1.png');
LI2= imread ('DATA2/person_008_db2_L2.png');

% imshow (LIl); imshow (LI2);

c = [222 272 300 270 221 194];
r = [21 21 75 121 121 75];
%J = regionfill (LI1, c, r)
% imshow (LI2);

BW = imbinarize(LI1);
imshowpair(LI1,BW,'montage')


