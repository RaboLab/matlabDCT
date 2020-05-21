function [dictionary,encode,efficiency] = DoLZ(Zcode)
%dict   字典
%coding   输出码表
%f   输出编码效率 平均码长/熵
count = 1;
[M,N] = size(Zcode);

Acode = zeros(1,M*N);
    for y = 1:M
        for x = 64:64:N
            Acode((count-1)*64+1:count*64) = Zcode(y,x-64+1:x);
            count = 1+count;
        end
    end
    [dictionary,encode,efficiency]=LZCore(Acode);
end




function [dictionary,encode,efficiency]=LZCore(seq)
[entropy]=Entropy(seq);
l=length(seq);
dictionary(1).sym=seq(1);
k=2;
index=0;
str=[];

%get a symbol from the source file,compare it to the symbols in the 
%dictionary,if there is,add the next symbol to the original symbol, 
%or else,add this symbol into the dictionary.
for i=2:l
    str=[str seq(i)];    
    for j=1:(k-1)
        index=0;
        if strcmp(dictionary(j).sym,str)
            index=1;
            break;
        end
    end
    if (index==0)
        dictionary(k).sym=str;
        k=k+1;
        str=[];       
    end
end 
%calculate the code length 
codelength=fix(log2(k-1))+1;
%encode the symbol in the dictionary,from 0,not 1.
for i=1:(k-1)
    dictionary(i).code=dec2bin((i-1),codelength);  
end
encode=LZencode(dictionary)
avglength=((codelength*length(dictionary))/length(seq));
efficiency=(entropy/avglength);
end

function encode=LZencode(dictionary)
%the function that encodes the source file
ld=length(dictionary);
encode='';
%output the dictionary.code in order,that is the encode sequence
for i=1:ld
    encode=[encode dictionary(i).code];
end
end

function [entropy]=Entropy(seq)
%the function that calculate the source entropy
alpha(1)=seq(1);
prob(1)=1;
l=length(seq);
k=2;
%statistic the symbol that in the source file and  the numbers.
for i=2:l
    %check whether there is the current symbol in the alpha array
    idx=find(alpha==seq(i));
    if isempty(idx)%if not,add it
        alpha(k)=seq(i);
        prob(k)=1;
        k=k+1;
    else
        prob(idx)=prob(idx)+1; %if there is, add 1
    end
end
%caculate the probability
prob=prob./l;
%caculate the entropy
entropy=-prob.*log2(prob);
entropy=sum(entropy(:));
end