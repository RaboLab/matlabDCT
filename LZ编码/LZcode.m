function [dictionary codelength]=LZcode(seq)
l=length(seq);
dictionary(1).sym=seq(1);
k=2;
index=0;
str='';
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
        str='';       
    end
end 
%calculate the code length 
codelength=fix(log2(k-1))+1;
%encode the symbol in the dictionary,from 0,not 1.
for i=1:(k-1)
    dictionary(i).code=dec2bin((i-1),codelength);   
end
end