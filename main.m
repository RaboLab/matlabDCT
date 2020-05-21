function [Huff_eff,diff] = main(n)
%diff : MSE
%Huff_eff:������
%LZ_eff: ������



%����ѹ������
matrix = rot90(triu(ones(8),8-n));
if(n>8)
    for x=1:8
        for y=1:8
            matrix(x,y)=1;          %save all
        end
    end
end

%��ȡͼƬ���ҶȻ�
gray = rgb2gray(imread('origin.png'));

%ʹ�����ú�������DCT�任
doubleimDCT = blkproc(gray, [8 8], @dct2);

%��������
Light=round(blkproc(doubleimDCT,[8,8],@QLight));

%ѹ������
Light=blkproc(Light,[8,8],'P1.*x', matrix);

%Z���α���
Zcode = Zigzag(Light);
Zcode=128+Zcode;
%----------------------------------------%
%����������
[ dict,Huff_len,Huff_eff ] = DoHuff(Zcode);                                           %codes : ����������      f��������
%����
Uncodes = UndoHuff(Huff_len,dict);    

%LZ����
%[dictionary,LZ_len,LZ_eff]=DoLZ(Zcode);
%����
%unLZ=UnLZ(dictionary);
%----------------------------------------%
%��Z�ֱ���
Uncodes = Uncodes - 128;
unZcode=Unzig(Uncodes);

%��������������
unLight = blkproc(Light, [8 8], @iQLight);  %unZcode

%��DCT�任
unDCT = blkproc(unLight, [8 8], @idct2);
%ӳ�䵽uint8��
unDCT = uint8(unDCT);
%չʾͼƬ
figure;
subplot(1,2,1); imshow(gray), title('ԭͼ');
if(n<9)
    subplot(1,2,2); imshow(unDCT), title(['����ѹ������Ϊ',num2str(n),'��ͼ��']);
else
    subplot(1,2,2); imshow(unDCT), title('ȫ��������ͼ��');
end
shape = size(gray);
%�����
xmar = im2double(gray - unDCT);
differ = double(gray) - double(unDCT);
differ = (differ(:))';
differ(find(differ<-150))=[];
differ(find(differ>150))=[];
se = xmar.^2;
diff = sum(se(:)) / (shape(1)*shape(2));
if(n<9)
    %subplot(2,2,[3,4]);hx1 = histogram(differ,'Normalization','pdf'),title(['����ѹ������Ϊ',num2str(n),'��MSEΪ:',num2str(diff),',��ʱ�ľַ����ͼ��']);
else
    %subplot(2,2,[3,4]);hx1 = histogram(differ,'Normalization','pdf'),title(['ȫ����ѹ������MSEΪ:',num2str(diff),',��ʱ�ľַ����ͼ��']);
end
hx1.Normalization = 'probability';hx1.BinWidth = 4;

end