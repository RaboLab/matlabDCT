function [Huff_eff,diff] = main(n)
%diff : MSE
%Huff_eff:编码率
%LZ_eff: 编码率



%定义压缩矩阵
matrix = rot90(triu(ones(8),8-n));
if(n>8)
    for x=1:8
        for y=1:8
            matrix(x,y)=1;          %save all
        end
    end
end

%读取图片并灰度化
gray = rgb2gray(imread('origin.png'));

%使用内置函数进行DCT变换
doubleimDCT = blkproc(gray, [8 8], @dct2);

%亮度量化
Light=round(blkproc(doubleimDCT,[8,8],@QLight));

%压缩量化
Light=blkproc(Light,[8,8],'P1.*x', matrix);

%Z字形编码
Zcode = Zigzag(Light);
Zcode=128+Zcode;
%----------------------------------------%
%霍夫曼编码
[ dict,Huff_len,Huff_eff ] = DoHuff(Zcode);                                           %codes : 霍夫曼编码      f：编码率
%解码
Uncodes = UndoHuff(Huff_len,dict);    

%LZ编码
%[dictionary,LZ_len,LZ_eff]=DoLZ(Zcode);
%解码
%unLZ=UnLZ(dictionary);
%----------------------------------------%
%反Z字编码
Uncodes = Uncodes - 128;
unZcode=Unzig(Uncodes);

%反亮度量化矩阵
unLight = blkproc(Light, [8 8], @iQLight);  %unZcode

%反DCT变换
unDCT = blkproc(unLight, [8 8], @idct2);
%映射到uint8域
unDCT = uint8(unDCT);
%展示图片
figure;
subplot(1,2,1); imshow(gray), title('原图');
if(n<9)
    subplot(1,2,2); imshow(unDCT), title(['量化压缩矩阵为',num2str(n),'的图像：']);
else
    subplot(1,2,2); imshow(unDCT), title('全部保留的图像：');
end
shape = size(gray);
%求误差
xmar = im2double(gray - unDCT);
differ = double(gray) - double(unDCT);
differ = (differ(:))';
differ(find(differ<-150))=[];
differ(find(differ>150))=[];
se = xmar.^2;
diff = sum(se(:)) / (shape(1)*shape(2));
if(n<9)
    %subplot(2,2,[3,4]);hx1 = histogram(differ,'Normalization','pdf'),title(['量化压缩矩阵为',num2str(n),'，MSE为:',num2str(diff),',此时的局方误差图像：']);
else
    %subplot(2,2,[3,4]);hx1 = histogram(differ,'Normalization','pdf'),title(['全保留压缩矩阵，MSE为:',num2str(diff),',此时的局方误差图像：']);
end
hx1.Normalization = 'probability';hx1.BinWidth = 4;

end