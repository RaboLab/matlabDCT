function zScanOut=Zigzag(a)
    [t,N] = size(a);
    M = N/8;
    N = N*8;
    zScanOut = zeros(M,N);
    count=1;
    for x = 0:8:t-8
        for y =0:8:t-8
            zScanOut(count:count+63)=Zigzagcore(a(x+1:x+8,y+1:y+8));
            count = count + 64;
        end
    end
end

function zScanOut=Zigzagcore(zScanIn)
%输入8*8的矩阵，输出Z形扫描结果
%分为两步分进行，第一部分为矩阵左上块，第二部分为右下块
N=8;
m=1;
%--------PART 1--------%
for k=1:N
    if(round(k/2)==k/2) 
        i=1;j=k;
    else
        i=k;j=1;
    end    
    zScanOut(m)=zScanIn(i,j);
    m=m+1;
    
    if(round(k/2)==k/2)
        while(i~=k) 
            i=i+1;j=j-1;zScanOut(m)=zScanIn(i,j);m=m+1;
        end
    else
        while(j~=k)
            i=i-1;j=j+1;zScanOut(m)=zScanIn(i,j);m=m+1;
        end
    end
end
%--------PART 2--------%
for k=(N+1):(2*N-1)
    if(round(k/2)==k/2)
        j=N;i=k+1-j;
    else
        i=N;j=k+1-i;
    end
    
    zScanOut(m)=zScanIn(i,j);
    m=m+1;
    
    if(round(k/2)==k/2) 
        while(i~=N)
            i=i+1;j=j-1;zScanOut(m)=zScanIn(i,j);m=m+1;
        end
    else
        while(j~=N)
            j=j+1;i=i-1;zScanOut(m)=zScanIn(i,j);m=m+1;
        end
    end
end
end
