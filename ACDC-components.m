clc
clear all
close all


 % ---- Figure 6.
img = imread('cameraman.jpg');
gray_img = im2gray(img);

% Orjinal gri seviye görüntüsünü gösterme
subplot(4,3,1);
imshow(gray_img);
title('Orjinal Görüntü');

% DCT transformunu uygulama
dct_img = dct2(gray_img);

% DC bileşeni ve ilk 30 AC bileşeninin katsayılarını alma
dct_coeff = dct_img(:); % dct_img adlı değişken, dct2() fonksiyonu ile hesaplanan DCT katsayılarını içerir. 
% dct_img matrisini tek boyutlu bir vektöre dönüştürür.
dc_coeff = dct_coeff(1);% dct_coeff vektörünün ilk elemanı, DC bileşenini temsil eder.
ac_coeff = dct_coeff(2:end); % dct_coeff vektörünün ikinci elemanından sonuna kadar olan elemanlar, AC bileşenlerini temsil eder.
ac_coeff_sorted = sort(abs(ac_coeff),'descend'); % ac_coeff vektöründeki AC katsayılarını büyüklüklerine göre sıralar.
ac_coeff_threshold = ac_coeff_sorted(round(length(ac_coeff_sorted)*0.3));
% AC bileşenlerinin yüzde 30'una karşılık gelen katsayı eşiği belirliyor.
ac_coeff(abs(ac_coeff) < ac_coeff_threshold) = 0;% vektöründeki katsayıların %90'ından fazlası olan katsayıları sıfırlar.
dct_coeff(2:end) = ac_coeff; % vektörünün ikinci elemanından sonuna kadar olan elemanlarını, işlenmiş AC katsayılarına eşitler.
dct_coeff(1) = 0; % DC bileşenini de kaldır
dct_img_filtered = reshape(dct_coeff,size(dct_img)); 
% İşlenmiş dct_coeff vektörünü, 
% orijinal boyutlarına yeniden şekillendirir ve dct_img_filtered adlı bir matrise kaydeder. 
% Bu, işlenmiş DCT katsayılarına dayalı filtrelenmiş görüntüyü temsil eder.

% İlk 30 AC bileşeninin katsayılarını alma ve sıralama

% Filtrelenmiş DCT görüntüsünü gösterme
subplot(4,3,2);
imshow(log(abs(dct_img_filtered)),[]); % log ölçeği ile gösterme
title('Filtrelenmiş DCT Görüntüsü');

% Inverse DCT transformunu uygulama
filtered_img = idct2(dct_img_filtered);

%30 oranında AC bileşenlerinin kaldırılması sonrası elde edilen ters DCT görüntüsünü gösterir.
subplot(4,3,3);
imshow(filtered_img,[]);
title('Inverse DCT Görüntüsü');


 % ---- Figure 7 

gray_img = im2gray(img);

% Orjinal gri seviye görüntüsünü gösterme
subplot(4,3,4);
imshow(gray_img);
title('Orjinal Görüntü');

% DCT transformunu uygulama
dct_img = dct2(gray_img);

% İlk 30 AC bileşeninin katsayılarını alma ve sıralama
dct_coeff = dct_img(:);
ac_coeff = dct_coeff(2:end);
ac_coeff_sorted = sort(abs(ac_coeff),'descend');
ac_coeff_threshold = ac_coeff_sorted(30); % İlk 30 bileşenin eşik değeri
ac_coeff(abs(ac_coeff) < ac_coeff_threshold) = 0;
dct_coeff(2:end) = ac_coeff;
dct_img_filtered = reshape(dct_coeff,size(dct_img));

% first 30 AC Components removed, DCT görüntüsünü gösterme
subplot(4,3,5);
imshow(log(abs(dct_img_filtered)),[]); % log ölçeği ile gösterme
title('30 AC Bileşeni Kaldırılmış DCT Görüntüsü');

% Inverse DCT transformunu uygulama
filtered_img = idct2(dct_img_filtered);

% Inverse DCT image after removing of first 30 AC Components
subplot(4,3,6);
imshow(filtered_img,[]);
title('30 AC Bileşeni Kaldırıldıktan Sonra Ters DCT Görüntüsü');


 %  ---- Figure 8 
gray_img = im2gray(img);

% Orjinal gri seviye görüntüsünü gösterme
subplot(4,3,7);
imshow(gray_img);
title('Orjinal Görüntü');

% DCT transformunu uygulama
dct_img = dct2(gray_img);

% DC bileşeni ve %30 end of the AC bileşenlerinin katsayılarını alma
dct_coeff = dct_img(:);
dc_coeff = dct_coeff(1);
ac_coeff = dct_coeff(2:end);
ac_coeff_sorted = sort(abs(ac_coeff),'descend');
ac_coeff_threshold = ac_coeff_sorted(round(length(ac_coeff_sorted)*0.3));
% en yüksek %30'unu seçmek için bir eşik değeri belirliyor.
ac_coeff(abs(ac_coeff) < ac_coeff_threshold) = 0;
dct_coeff(2:end) = ac_coeff;
dct_coeff(1) = 0; % DC bileşenini de kaldır
dct_img_filtered = reshape(dct_coeff,size(dct_img));

% Filtrelenmiş DCT görüntüsünü gösterme
subplot(4,3,8);
imshow(log(abs(dct_img_filtered)),[]); % log ölçeği ile gösterme
title('%30 End of AC Bileşenleri Kaldırılmış DCT Görüntüsü');

% Inverse DCT transformunu uygulama
filtered_img = idct2(dct_img_filtered);

% %30 end of the AC Components removed, Inverse DCT image
subplot(4,3,9);
imshow(filtered_img,[]);
title('%30 End of AC Bileşenleri Kaldırılmış Ters DCT Görüntüsü');



 % ---- Figure 9 
 % Görüntüyü yükleme
img = imread('cameraman.jpg');
gray_img = im2gray(img);


% Orjinal gri seviyeli görüntüyü gösterme
subplot(4,3,10);
imshow(img);
title('Orjinal Görüntü');

% DCT transformunu uygulama
dct_img = dct2(img);

% DC bileşeni ve son %90 AC bileşeninin katsayılarını alma
dct_coeff = dct_img(:);
dc_coeff = dct_coeff(1); % dct_coeff vektörünün ilk elemanı, DC bileşenini temsil eder.
ac_coeff = dct_coeff(2:end); % dct_coeff vektörünün ikinci elemanından sonuna kadar olan elemanlar, AC bileşenlerini temsil eder.
ac_coeff_sorted = sort(abs(ac_coeff),'descend');  % ac_coeff vektöründeki AC katsayılarını büyüklüklerine göre sıralar.
ac_coeff_threshold = ac_coeff_sorted(round(length(ac_coeff_sorted)*0.9));
% Sıralanmış AC katsayılarının %90'ını geçen en küçük katsayıyı seçer. Bu katsayı, son %10'u temsil eden en küçük katsayıdır.
ac_coeff(abs(ac_coeff) > ac_coeff_threshold) = 0; % vektöründeki katsayıların %90'ından fazlası olan katsayıları sıfırlar.
dct_coeff(2:end) = ac_coeff; % vektörünün ikinci elemanından sonuna kadar olan elemanlarını, işlenmiş AC katsayılarına eşitler.
dct_coeff(1) = 0; % DC bileşenini de kaldır 
dct_img_filtered = reshape(dct_coeff,size(dct_img));
 % İşlenmiş dct_coeff vektörünü, 
 % orijinal boyutlarına yeniden şekillendirir ve dct_img_filtered adlı bir matrise kaydeder.
 % Bu, işlenmiş DCT katsayılarına dayalı filtrelenmiş görüntüyü temsil eder.

% Filtrelenmiş DCT görüntüsünü gösterme
subplot(4,3,11);
imshow(log(abs(dct_img_filtered)),[]); % log ölçeği ile gösterme
title('Filtrelenmiş DCT Görüntüsü');

% Inverse DCT transformunu uygulama
filtered_img = idct2(dct_img_filtered);

% %90 uç AC bileşenleri kaldırılmış, Inverse DCT görüntüsü
subplot(4,3,12);
imshow(filtered_img,[]);
title('%90 uç AC bileşenleri kaldırılmış, Inverse DCT Görüntüsü');




 % % VIOLA JOY 
 % 
 % % Giriş görüntüsünü yükle
 % img = imread('toplulukfoto.jpeg');
 % 
 % % Yüz tespiti için nesne tanıma sınıflandırıcısını yükle
 % faceDetector = vision.CascadeObjectDetector("haarcascade_frontalface_alt2.xml");
 % 
 % % Yüz tespiti yap
 % bbox = step(faceDetector, img);
 % 
 % % Yüzleri dikdörtgen kutular şeklinde çevreleyen alanları göster
 % imgOut = insertObjectAnnotation(img, 'rectangle', bbox, 'Face');
 % 
 % % Sonucu göster
 % figure, imshow(imgOut), title('Detected faces');
 % 
 % 




