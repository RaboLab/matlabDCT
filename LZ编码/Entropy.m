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