clear all

f = @(x) x^4 - 4 * x^2 + 4;
x0 = 1.2;

% 普通Newton法 (线性收敛)
fprintf('解法一：普通Newton法\n');
newtonIter(f, x0);

% 用Newton法解 mu(x) = 0，转化为单重根问题 (二阶收敛)
fprintf('解法二：对 mu(x) = f(x) / f''(x) 使用Newton法\n');
syms x;
fPrimeSym = diff(f(x), x);
fPrime = matlabFunction(fPrimeSym);
mu = @(x) f(x) / fPrime(x);
newtonIter(mu, x0);

function root = newtonIter(f, x0)
    % Newton法

    maxIter = 500;
    eps = 1e-5;

    syms x;
    fPrimeSym = diff(f(x), x);
    fPrime = matlabFunction(fPrimeSym);

    phi = @(x) x - f(x) / fPrime(x);
    xPrev = phi(x0);
    nIter = 0;

    for i=1:maxIter
        xIter = phi(xPrev);
        if abs(xIter - xPrev) < eps
            nIter = i;
            break;
        end
        xPrev = xIter;
    end

    root = xIter;
    fprintf('Newton法在%d次迭代后收敛，得到的根为：%.4f\n', nIter, root);
end