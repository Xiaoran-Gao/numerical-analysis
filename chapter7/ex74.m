clear all

f = @(x) 3 * x^2 - exp(x);

% 原迭代格式线性收敛，Steffenson加速后二阶收敛
phi = @(x) 2 * log(x) + log(3);
x0 = 3.5; % 初值可在[3, 4]区间内任取
stfsIter(phi, x0);

function root = stfsIter(phi, x0)
    % Steffenson加速法

    maxIter = 500;
    eps = 1e-5;

    flag = 0; % 迭代格式是否收敛
    nIter = 0;

    phiStfs = @(x) x - ((phi(x) - x)^2 / (phi(phi(x)) - 2*phi(x) + x));
    xPrev = phiStfs(x0);

    for i=1:maxIter
        xIter = phiStfs(xPrev);
        if abs(xIter - xPrev) < eps
            flag = 1;
            nIter = i;
            break;
        end
        xPrev = xIter;
    end

    if flag == 1
        root = xIter;
        fprintf('该迭代格式在%d次迭代后收敛，得到的根为：%.4f\n', nIter, xIter);
    else
        root = NaN;
        fprintf('该迭代格式在%d次迭代内不收敛\n', maxIter);
    end
end