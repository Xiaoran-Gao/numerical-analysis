clear all

f = @(x) x^2 - 3;

% 不动点迭代法求解
phi1 = @(x) x - (x^2 - 3) / 4; % 局部线性收敛
phi2 = @(x) 1/2 * (x + 3/x); % 局部二阶收敛
maxIter = 500;
eps = 1e-5;

x0 = 1.5;
xPrev1 = phi1(x0); xPrev2 = phi2(x0);
nIter1 = 0; nIter2 = 0;

for i=1:maxIter
    xIter1 = phi1(xPrev1);
    if abs(xIter1 - xPrev1) < eps
        nIter1 = i;
        break;
    end
    xPrev1 = xIter1;
end

fprintf('第1种迭代格式在%d次迭代后收敛，得到的根为：%.4f\n', nIter1, xIter1);

for j=1:maxIter
    xIter2 = phi2(xPrev2);
    if abs(xIter2 - xPrev2) < eps
        nIter2 = j;
        break;
    end
    xPrev2 = xIter2;
end

fprintf('第2种迭代格式在%d次迭代后收敛，得到的根为：%.4f\n', nIter2, xIter2);