%读取图片并灰度化

%把main给封装了 外层留啥？ 量化位数 该次编码长度 该次编码率 该次误差直方图 
%main里面有啥？ 量化 霍夫曼编码 LZ编码 展示图片 误差直方图



% gray = rgb2gray(imread('lena.bmp'));
% gray = rgb2gray(imread('lena.png'));
gray = imread('lena.bmp');



figure(1), imshow(gray), title('origin!!');
%使用内置函数进行DCT变换
t = dctmtx(8);
doubleimDCT = blkproc(gray, [8 8], @dct2);

%量化
Light=round(blkproc(doubleimDCT,[8,8],@QLight));

unLight = blkproc(Light, [8 8], @iQLight);

unDCT = blkproc(unLight, [8 8], @idct2);

%映射到uint8域
unxDCT = uint8(unDCT);

%展示图片
figure(2), imshow(unDCT), title('没有映射uint8域');

figure(3), imshow(unxDCT), title('映射uint8域');
disp('Complete!')