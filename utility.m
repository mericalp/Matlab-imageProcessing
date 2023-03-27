classdef utility
   methods(Static)
        function getCroppedImages(path, croppedPath, extension)
          imagefiles = dir(strcat(path,extension));      
          files_count = length(imagefiles);
          %images = cell(files_count);
          if files_count == 0
              return;
          else
              for i=1:files_count
                 currentfilename = imagefiles(i).name;
                 currentimage = imread(strcat(path,currentfilename));

                 nIMG = utility.cropImage(currentimage);
                 imwrite(nIMG,strcat(croppedPath,currentfilename))
              end

              return;
          end
        end
        
        function croppedImage = cropImage(currentimage)
             BWg = rgb2gray(currentimage);
             BW = imbinarize(BWg);

             rows = sum(BW, 2);     %image matrix row toplanları 
             columns = sum(BW, 1);  %image matrix column toplanları 

             %image max çerçeve
             colBegin = 1;
             colEnd = length(columns);
             rowBegin = 1;
             rowEnd = length(rows);
             
             maxCol = colEnd;
             maxRow = rowEnd;

             %image max çerçeveden sihay bölgenin çıkartılıp image size küçültme işlemi
             while (columns(colBegin) == 0)
               colBegin = colBegin + 1;
             end
             while (columns(colEnd) == 0)
               colEnd = colEnd - 1;
             end
             while (rows(rowBegin) == 0)
                 rowBegin = rowBegin + 1;
             end
             while (rows(rowEnd) == 0)
               rowEnd = rowEnd - 1;
             end

             if (colEnd + 10) < maxCol
                 colEnd = colEnd + 10;
             else
                 colEnd = maxCol;
             end
             
             if (colBegin - 10) > 0
                 colBegin = colBegin - 10;
             else
                 colBegin = 1;
             end

             if (rowEnd + 10) < maxRow
                 rowEnd = rowEnd + 10;
             else
                 rowEnd = maxRow;
             end
             
             if (rowBegin - 10) > 0
                 rowBegin = rowBegin - 10;
             else
                 rowBegin = 1;
             end
             
             croppedImage = currentimage(rowBegin:rowEnd, colBegin:colEnd,:);
        end       
        
        function res = smoothLine(m, rpt)
           col=size(m,2)
           for j=1:rpt
               for i=2:col-1
                   onceki = m(1,i-1);
                   point = m(1,i);
                   sonraki = m(1,i+1);
                   if (onceki < point && sonraki < point) || (onceki > point && sonraki > point)
                       m(1,i) = round((onceki + sonraki) / 2);
                   end
               end
           end
           res = m;
        end
   end
end
