function encode=LZencode(dictionary)
%the function that encodes the source file
ld=length(dictionary);
encode='';
%output the dictionary.code in order,that is the encode sequence
for i=1:ld
    encode=[encode dictionary(i).code];
end
end