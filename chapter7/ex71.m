clear all

f = @(x) x^3 - x - 1;

% 不动点迭代法求解
phi = @(x) (x+1) ^ (1/3);
maxIter = 500;
eps = 1e-5;

x0 = 1.5; % 初值可在[1, 2]区间内任取
xPrev = phi(x0);
flag = 0; % 迭代格式是否收敛
nIter = 0;

for i=1:maxIter
    xIter = phi(xPrev);
    if abs(xIter - xPrev) < eps
        flag = 1;
        nIter = i;
        break;
    end
    xPrev = xIter;
end

if flag == 1
    fprintf('不动点迭代法在%d次迭代后收敛，得到的根：%.4f\n', nIter, xIter);
else
    fprintf('当前不动点迭代格式在%d次迭代内不收敛\n', maxIter);
end

% fsolve函数求解
xSol = fsolve(f, x0);
fprintf('fsolve函数得到的根：%.4f\n', xSol);