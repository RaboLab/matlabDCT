function [ dict,codes,f ] = DoHuff(Zcode)
%dict   �ֵ�
%coding   ������
%f   �������Ч�� ƽ���볤\��
count = 1;
[M,N] = size(Zcode);

Acode = zeros(1,M*N);
    for y = 1:M
        for x = 64:64:N
            Acode((count-1)*64+1:count*64) = Zcode(y,x-64+1:x);
            count = 1+count;
        end
    end
    [ dict,codes,f ] = HuffCode(Acode);
end

function [ dict,codes,f ] = HuffCode(Acode)

%dict   �ֵ�
%coding   ������
%f   �������Ч�� ƽ���볤\��

[M,N] = size(Acode);

Vmax = max(Acode);
Vmin = min(Acode);
P = zeros(1,Vmax-Vmin+1);
for i = Vmin:Vmax
    P(i+1-Vmin) = length(find(Acode == i))/(M*N);
end
symbols=Vmin:Vmax;
[dict,avelen] = huffmandict(symbols,P);

%����
codes = huffmanenco(Acode,dict); 

%����������� �������� ��P(i)=0��ֱ���趨H1(i)=0
H1 = zeros(1,Vmax-Vmin+1);
for i = 1:Vmax-Vmin+1
   if(P(i)~=0)
       H1(i)=log2(P(i));
   end
end
    f=(-P*(H1'))/avelen;
end



