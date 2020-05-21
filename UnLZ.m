function   Uncodes=UnLZ(dictionary);
    count = 1;
    origin = UnLZCore(dictionary);
    [~,M] = size(origin);
    M = M^(1/2);
    N = M*8;
    M = M/8;
    Uncodes = zeros([M,N]);
    for y = 1:M
        for x = 64:64:N
            Uncodes(y,x-64+1:x) = origin((count-1)*64+1:count*64);
            count = 1+count;
        end
    end
end


function decode=UnLZCore(dictionary)
%the function that decodes the encode file
ld=length(dictionary);
decode=[];
%output the dictionary.sym in order,that is the decode sequence
for i=1:ld
    decode=[decode dictionary(i).sym];
end
end
    
