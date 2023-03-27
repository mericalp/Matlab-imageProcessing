clc
clear all
close all

I = imread('kendifotom.tif');
I = rgb2gray(I)
% glcm = graycomatrix(I,'Offset',[4 45]);
glcm = graycomatrix(I);
glcm = glcm./max(glcm(:));
imshow(I)


% Var = var(glcm(:))
% E = 0;
% 
% for i = 1:size(glcm,1)
%     for j = 1:size(glcm,2)
%         E = E + (double(glcm(i,j)))^2;
%     end
% end
% 
% E
% E = 0;
% for i = 1:size(I,1)
%     for j = 1:size(I,2)
%         E = E + (double(I(i,j)))^2;
%     end
% end
% E
% I = [4 55]





% Energy islemi (Feature 1 )
% I = [3 2 4 ; 0 6 7 ; 2 5 1]
E = 0;
for i = 1:size(glcm,1)
    for j = 1:size(glcm,2)
        E = E + (double(glcm(i,j)))^2;
    end
end
disp(['energy:', num2str(E)]);

% Entropy islemi (Feature 2)
% I = [3 2 4 ; 0 6 7 ; 2 5 1]
Ent = 0;
for i = 1:size(glcm,1)
    for j = 1:size(glcm,2)
        Ent = Ent - log2(double(glcm(i,j))^double(glcm(i,j)));
    end
end
disp(['entropy:', num2str(Ent)]);

% Contrast islemi (Feature 3)
% I = [3 2 4 ; 0 6 7 ; 2 5 1]
Contrast = 0;
for i = 1:size(glcm,1)
    for j = 1:size(glcm,2)
        Contrast = Contrast + ((i-j)^2)*(double(glcm(i,j)));
    end
end
disp(['contrast:', num2str(Contrast)]);


% Max Probability islemi (Feature 5)
% I = [3 2 4 ; 0 6 7 ; 2 5 1]
Max = glcm(1,1);
for i = 1:size(glcm,1)
    for j = 1:size(glcm,2)
        if Max<= glcm(i,j)
            Max = glcm(i,j);
        end
    end
end
disp(['max:', num2str(Max)]);

% Homogeneity islemi (Feature 6)
% I = [3 2 4 ; 0 6 7 ; 2 5 1]
Homogeneity = 0;
for i = 1:size(glcm,1)
    for j = 1:size(glcm,2)
        Homogeneity = Homogeneity + ((double(glcm(i,j))) / (1 + abs(i-j)));
    end
end
disp(['homogeneity:', num2str(Homogeneity)]);


% Dissimilarity islemi (Feature 8)
% I = [3 2 4 ; 0 6 7 ; 2 5 1]
Dissimilarity = 0;
for i = 1:size(glcm,1)
    for j = 1:size(glcm,2)
        Dissimilarity = Dissimilarity + (abs(i-j)*((double(glcm(i,j)))));
    end
end
disp(['dissimilarity:', num2str(Dissimilarity)]);


% Mean islemi (Feature 9)
% NA = [3 2 4 ; 0 6 7 ; 2 5 1];
% [n a] = size(NA)
[m n] = size(glcm);
Mean = 0;
for i = 1:size(glcm,1)
    for j = 1:size(glcm,2)
        Mean = Mean + ((double(glcm(i,j)))/ (m*n));
    end
end
disp(['mean:', num2str(Mean)]);





% % Correlation islemi (Feature 4)
% MN = [3 2 4 ; 0 6 7 ; 2 5 1];
% Correlation = 0;
% for i = 1:size(MN,1)
%     for j = 1:size(MN,2)
%         m_i = sum(i *sum(MN,2));
%         m_j = sum(j *sum(MN,1));
%         sigma_i = sum((i - m_i)^2*sum(MN,2));
%         sigma_j = sum((j - m_j)^2*sum(MN,1));
%         cov_ij = sum(sum((i - m_i)^2)* sum(MN,1));
%         Correlation = cov_ij/(sqrt(sigma_i)*sqrt(sigma_j));
%     end
% end
% disp(['correlation:', num2str(Correlation)]);







