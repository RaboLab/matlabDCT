function decode=LZdecode(dictionary)
%the function that decodes the encode file
ld=length(dictionary);
decode=[];
%output the dictionary.sym in order,that is the decode sequence
for i=1:ld
    decode=[decode dictionary(i).sym];
end
end
