%��ȡͼƬ���ҶȻ�

%��main����װ�� �����ɶ�� ����λ�� �ôα��볤�� �ôα����� �ô����ֱ��ͼ 
%main������ɶ�� ���� ���������� LZ���� չʾͼƬ ���ֱ��ͼ



% gray = rgb2gray(imread('lena.bmp'));
% gray = rgb2gray(imread('lena.png'));
gray = imread('lena.bmp');



figure(1), imshow(gray), title('origin!!');
%ʹ�����ú�������DCT�任
t = dctmtx(8);
doubleimDCT = blkproc(gray, [8 8], @dct2);

%����
Light=round(blkproc(doubleimDCT,[8,8],@QLight));

unLight = blkproc(Light, [8 8], @iQLight);

unDCT = blkproc(unLight, [8 8], @idct2);

%ӳ�䵽uint8��
unxDCT = uint8(unDCT);

%չʾͼƬ
figure(2), imshow(unDCT), title('û��ӳ��uint8��');

figure(3), imshow(unxDCT), title('ӳ��uint8��');
disp('Complete!')