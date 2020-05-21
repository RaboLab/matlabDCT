function   Uncodes=UndoHuff(codes,dict)
    count = 1;
    origin = huffmandeco(codes,dict);
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

    