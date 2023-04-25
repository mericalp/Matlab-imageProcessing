clc, clear, close all;
import utility.*;
LI1= imread('DATA2/person_009_db2_R3.png');

nIMG = cropImage(LI1);

gIMG = rgb2gray(nIMG);
BW2 = imbinarize(gIMG);
BW2 = imfill(BW2, 'holes');

[row,col]=size(BW2);

Threshold = 175;
A = gIMG > Threshold;

%binarize da siyah olan elin dışında kalan bölümler beyaza çevrilir
A(BW2(:)==0)=1;

%imshowpair(gIMG,A,'montage');

BW2Holes = imfill(A, 'holes');

gIMG2 = zeros(row,col);
gIMG2 = uint8(gIMG2);
gIMG2(:) = 255;
gIMG3 = gIMG2;

Agray = gIMG2;
Agray(:) = 0;
BW2HolesGray = Agray;
BW2Gray = Agray;

Agray(A(:)==1) = 255;
BW2HolesGray(BW2Holes(:)==1) = 255;
BW2Gray(BW2(:)==1) = 255;

%binarized ve imfill holes olan pixelleri grayscale den alıp yeni image oluşturu
gIMG2(A(:)==0) = gIMG(A(:)==0);
gIMG3(BW2Holes(:)==0) = gIMG(BW2Holes(:)==0);

%4 image birleştirme
position = [1 5];
position2 = [1 5; 1 30;1 55;1 80;1 105;1 130;1 155;1 180;1 205;];

txt1 = '1-Original Cropped Image';
txt2 = '2-Binarized Image';
txt3 = strcat('3-Threshold < ', string(Threshold), ' 0/1 Image');
txt4 = '4- Fill Holes (Image 3)';
txt5 = '5- Images 1 & 3 Mix';
txt6 = '6- Images 1 & 4 Mix';

onlyValues = false;

fe3 = extractFeatures(Agray, onlyValues);
fe3(1,1) = txt3;
txt3_1 = fe3;

fe4 = extractFeatures(BW2HolesGray, onlyValues);
fe4(1,1) = txt4;
txt4_1 = fe4;

fe5 = extractFeatures(gIMG2, onlyValues);
fe5(1,1) = txt5;
txt5_1 = fe5;

fe6 = extractFeatures(gIMG3, onlyValues);
fe6(1,1) = txt6;
txt6_1 = fe6;

lastImage=[insertText(gIMG,position,txt1), insertText(Agray,position2,txt3_1), insertText(gIMG2,position2,txt5_1);
           insertText(BW2Gray,position,txt2), insertText(BW2HolesGray,position2,txt4_1), insertText(gIMG3,position2,txt6_1)];

createImages = false;
createExcel = true;
threshold = 175;

processImages('DATA2/', 'DATA2Processed/', '*.png', threshold, createImages, createExcel);

imshow(lastImage);

%a=gIMG2(:);      % vektöre çevirdik
%b=find(a~=255);  % 255 ler çıkarıldı

function fe = extractFeatures(LIgray, onlyValues)

    glcm = graycomatrix(LIgray);
    glcm = glcm./max(glcm(:));

    [row2, col2]=size(glcm);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   Energy
    Energy_glcm = 0;

    for i=1:row2
        for j=1:col2
            Energy_glcm = Energy_glcm + double((glcm(i,j)^2));
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   Entropy
    Entropy_glcm = 0;


    for i=1:row2
        for j=1:col2
            %eps ile karşılaştıralım, mail atılacak
            %if (glcm(i,j) ~= 0)        
               Entropy_glcm = Entropy_glcm - double((glcm(i,j)*log2((glcm(i,j)+eps)) ));
            %end   
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   Contrast
    Contrast_glcm = 0;

    for i=1:row2
        for j=1:col2
            Contrast_glcm = Contrast_glcm + double(abs(i-j)^2*glcm(i,j));
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   Correlation
    Correlation_glcm = 0;

    emRM = sum(glcm,2)';
    emCM = sum(glcm,1);
    mur = 0;
    muc = 0;
    varr=0;
    varc=0;

    for i=1:size(emRM,2)
        mur = mur + (i * emRM(i));
    end
    for i=1:size(emCM,2)
        muc = muc + (i * emCM(i));
    end
    for i=1:size(emRM,2)
        varr = varr + (((i - mur)^2)* emRM(i));
    end
    for i=1:size(emCM,2)
        varc = varc + (((i - muc)^2)* emCM(i));
    end
    R=sqrt(varr);
    C=sqrt(varc);
    VM = (R*C);

    for i=1:row2
        for j=1:col2
            Correlation_glcm = Correlation_glcm + double((i-mur)*(j-muc)* glcm(i,j)) / (VM);
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   MaximumProbability
    MaximumProbability_glcm = 0;

    MaximumProbability_glcm = max(double(glcm(:)));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   Homogeneity
    Homogeneity_glcm = 0;

    for i=1:row2
        for j=1:col2
            Homogeneity_glcm = Homogeneity_glcm + double( glcm(i,j) /(1+abs(i-j)) );
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   Dissimilarity
    Dissimilarity_glcm = 0;

    for i=1:row2
        for j=1:col2
            Dissimilarity_glcm = Dissimilarity_glcm + double( glcm(i,j) * abs(i-j) );
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   Mean
    Mean_glcm = 0;

    for i=1:row2
        for j=1:col2
            Mean_glcm = Mean_glcm + double(glcm(i,j));
        end
    end

    Mean_glcm = Mean_glcm / (row2 * col2);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if (onlyValues == true)
       fe = [ Energy_glcm Entropy_glcm Contrast_glcm Correlation_glcm MaximumProbability_glcm Homogeneity_glcm Dissimilarity_glcm Mean_glcm ];        
    else
       fe = ['Başlık'
             (strcat('Energy:', string(Energy_glcm))) 
             (strcat('Entropy:', string(Entropy_glcm)))
             (strcat('Contrast:', string(Contrast_glcm)))
             (strcat('Correlation:', string(Correlation_glcm)))
             (strcat('MaximumProbability:', string(MaximumProbability_glcm)))
             (strcat('Homogeneity:', string(Homogeneity_glcm)))
             (strcat('Dissimilarity:', string(Dissimilarity_glcm)))
             (strcat('Mean:', string(Mean_glcm)))
            ];
    end    
end

function processImages(path, processedPath, extension, threshold, createImages, createExcel)
  imagefiles = dir(strcat(path,extension));      
  files_count = length(imagefiles);
  
  A1 = zeros(files_count, 8);
  A3 = zeros(files_count, 8);
  A4 = zeros(files_count, 8);
  A5 = zeros(files_count, 8);
  A6 = zeros(files_count, 8);
  
  %images = cell(files_count);
  if files_count == 0
      return;
  else
      position = [1 5];
      position2 = [1 5; 1 30;1 55;1 80;1 105;1 130;1 155;1 180;1 205;];
      
      txt1 = '1-Original Cropped Image';
      txt2 = '2-Binarized Image';
      txt3 = strcat('3-Threshold < ', string(threshold), ' 0/1 Image');
      txt4 = '4- Fill Holes (Image 3)';
      txt5 = '5- Images 1 & 3 Mix';
      txt6 = '6- Images 1 & 4 Mix';
      
      for i=1:files_count
        currentfilename = imagefiles(i).name;
        currentimage = imread(strcat(path,currentfilename));

        nIMG = utility.cropImage(currentimage);
         
        gIMG = rgb2gray(nIMG);
        BW2 = imbinarize(gIMG);
        BW2 = imfill(BW2, 'holes');
        
        [row,col]=size(BW2);

        A = gIMG > threshold;

        %binarize da siyah olan elin dışında kalan bölümler beyaza çevrilir
        A(BW2(:)==0)=1;

        %imshowpair(gIMG,A,'montage');

        BW2Holes = imfill(A, 'holes');

        gIMG2=zeros(row,col);
        gIMG2=uint8(gIMG2);
        gIMG2(:)=255;
        gIMG3=gIMG2;

        Agray=gIMG2;
        Agray(:)=0;
        BW2HolesGray=Agray;
        BW2Gray=Agray;

        Agray(A(:)==1)=255;
        BW2HolesGray(BW2Holes(:)==1)=255;
        BW2Gray(BW2(:)==1)=255;

        %binarized ve imfill holes olan pixelleri grayscale den alıp yeni image oluşturu
        gIMG2(A(:)==0)=gIMG(A(:)==0);
        gIMG3(BW2Holes(:)==0)=gIMG(BW2Holes(:)==0);
        
        if (createImages == true)
            fe1 = extractFeatures(gIMG, true);

            fe3 = extractFeatures(Agray, true);
    %         fe3(1,1) = txt3;
    %         txt3_1 = fe3;

            fe4 = extractFeatures(BW2HolesGray, true);
    %         fe4(1,1) = txt4;
    %         txt4_1 = fe4;

            fe5 = extractFeatures(gIMG2, true);
    %         fe5(1,1) = txt5;
    %         txt5_1 = fe5;

            fe6 = extractFeatures(gIMG3, true);
    %         fe6(1,1) = txt6;
    %         txt6_1 = fe6;

            lastImage=[insertText(gIMG,position,txt1), insertText(Agray,position2,txt3_1), insertText(gIMG2,position2,txt5_1);
                       insertText(BW2Gray,position,txt2), insertText(BW2HolesGray,position2,txt4_1), insertText(gIMG3,position2,txt6_1)];       

            imwrite(lastImage,strcat(processedPath,currentfilename))
        end
        
        if (createExcel == true)
            fe1 = extractFeatures(gIMG, true);
            fe3 = extractFeatures(Agray, true);
            fe4 = extractFeatures(BW2HolesGray, true);
            fe5 = extractFeatures(gIMG2, true);
            fe6 = extractFeatures(gIMG3, true);
            
            A1(i,:) = fe1(1,:);
            A3(i) = fe3(1);
            A4(i) = fe4(1);
            A5(i) = fe5(1);
            A6(i) = fe6(1);
        end
      end
      
      if (createExcel == true)
          col_header={'Energy' 'Entropy' 'Contrast' 'Correlation' 'MaximumProbability' 'Homogeneity' 'Dissimilarity' 'Mean'};
          xlswrite('A1.xlsx',col_header,'Sheet1','A1');
          xlswrite('A1.xlsx',A1,'Sheet1','A2');
          xlswrite('A3.xlsx',col_header,'Sheet1','A1');
          xlswrite('A3.xlsx',A3,'Sheet1','A2');
          xlswrite('A4.xlsx',col_header,'Sheet1','A1');
          xlswrite('A4.xlsx',A4,'Sheet1','A2');
          xlswrite('A5.xlsx',col_header,'Sheet1','A1');
          xlswrite('A5.xlsx',A5,'Sheet1','A2');
          xlswrite('A6.xlsx',col_header,'Sheet1','A1');
          xlswrite('A6.xlsx',A6,'Sheet1','A2');
      end

      return;
  end
end
