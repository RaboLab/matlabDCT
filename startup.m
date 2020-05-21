
%eff: 编码率
%diff：误差
diff = zeros(1,9);
eff = zeros(1,9);
n=0;
n = n+1;
[eff(n),diff(n)] = main(n);
disp('comp!');
n = n+1;
[eff(n),diff(n)] = main(n);
disp('comp!');
n = n+1;
[eff(n),diff(n)] = main(n);
disp('comp!');
n = n+1;
[eff(n),diff(n)] = main(n);
disp('comp!');
n = n+1;
[eff(n),diff(n)] = main(n);
disp('comp!');
n = n+1;
[eff(n),diff(n)] = main(n);
disp('comp!');
n = n+1;
[eff(n),diff(n)] = main(n);
disp('comp!');
n = n+1;
[eff(n),diff(n)] = main(n);
disp('comp!');
n = n+1;
[eff(n),diff(n)] = main(n);
disp('comp!');
mn = zeros(1,9);
for c= 1:9
    mn(c)=c;
end
figure;
subplot(2,1,1);plot(mn,diff); title('均方误差与压缩量化矩阵的关系'); xlabel('压缩矩阵大小'); ylabel('均方误差值');
subplot(2,1,2);plot(mn,eff); title('编码率与压缩量化矩阵的关系'); xlabel('压缩矩阵大小'); ylabel('编码率');