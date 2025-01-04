clear all

digits(3);

% 解法一
S0 = str2double(string(vpa(log(6) - log(5))));
S = zeros(1, 8);
S(1) = str2double(string(vpa(1/1 - 5*S0)));
for i = 2:8
    S(i) = str2double(string(vpa(1/i - 5*S(i-1))));
end
disp(S);

% 解法二
R8 = str2double(string(vpa(1/2 * (1/(5*9) + 1/(6*9)))));
R = zeros(1, 7);
R(7) = str2double(string(vpa(1/(5*8) - 1/5*R8)));
for i = 6:-1:1
    R(i) = str2double(string(vpa(1/(5*(i+1)) - 1/5*R(i+1))));
end
disp([R R8]);

% 真实值
T = zeros(1, 8);
for i = 1:8
    T(i) = vpa(integral(@(x) x.^i ./ (x+5), 0, 1));
end

figure;
hold on;
errS = abs(S - T);
plot(log(errS));
errR = abs([R R8] - T);
plot(log(errR));
legend('解法1', '解法2');
hold off;