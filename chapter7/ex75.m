clear all

f = @(x) x * exp(x) - 1;
x0 = 1;
newtonIter(f, x0);

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