
%eff: ������
%diff�����
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
subplot(2,1,1);plot(mn,diff); title('���������ѹ����������Ĺ�ϵ'); xlabel('ѹ�������С'); ylabel('�������ֵ');
subplot(2,1,2);plot(mn,eff); title('��������ѹ����������Ĺ�ϵ'); xlabel('ѹ�������С'); ylabel('������');