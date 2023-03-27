clc, clear;
import utility.*;
LI1= imread('DATA2/person_008_db2_L1.png');

%c = [222 272 300 270 221 194]; r = [21 21 75 121 121 75];
%J = regionfill(LI1,c,r); imshow(J);

BWg = rgb2gray(LI1);
BW = imbinarize(BWg);

figure(1);
%imshow(LI1);
%figure(2);
%imshow(BW);
imshowpair(LI1,BW,'montage');

%figure(2);
nIMG = cropImage(LI1);
%nIMG = LI1;
%imshow(nIMG);

gIMG = rgb2gray(nIMG);
BW2 = imbinarize(gIMG);

[row,col]=size(BW2);
mp=zeros(1,col);
mp2=zeros(1,col);

for i=1:col
    for j=1:row
        if BW2(j,i) > 0
           mp(1,i)=j;
        end

        if gIMG(j,i) > 29   %grayscale image de en makul renk seviyesi 29
           mp2(1,i)=j;
        end
    end
end

mp = smoothLine(mp,2);
mp2 = smoothLine(mp2,2);

%for i=2:col-1
%   onceki = mp2(1,i-1);
%   point = mp2(1,i);
%   sonraki = mp2(1,i+1);
%   if (onceki < point && sonraki < point) || (onceki > point && sonraki > point)
%       mp2(1,i) = round((onceki + sonraki) / 2);
%   end
%end    

for i=1:col
    if mp(1,i) > 0   %rgb(50,205,50) limegreen
       nIMG(mp(1,i),i,1)= 50; nIMG(mp(1,i),i,2)= 205; nIMG(mp(1,i),i,3)= 50;
    end
    if mp2(1,i) > 0   %255 beyaz point     
       gIMG(mp2(1,i),i)= 255;   
    end    
end

gIMG2 = gIMG;
for i=1:row
    for j=1:col
        if gIMG2(i,j) > 165   %255 beyaz point     
           gIMG2(i,j)= 255;
        end    
    end
end

figure(3);
imshow(nIMG);
	
figure(4);
imshow(gIMG);

figure(5);
imshow(gIMG2);

rows = sum(BW, 2);     %image matrix row toplanları
columns = sum(BW, 1);  %image matrix column toplanları

%image max çerçeve
colBegin = 1;
colEnd = length(columns);
rowBegin = 1;
rowEnd = length(rows);


%                 source    destination   extension
%getCroppedImages('DATA2/', 'DATA2crop/', '*.png');

