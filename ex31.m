clear all

legendre(4);

function nCoef = legendre(n)
    % 计算n次Legendre多项式的系数（n >= 1）

    coef = zeros(n+1, n+1);
    coef(1, n+1) = 1;
    coef(2, n:n+1) = [1, 0];
    fprintf('P0 = 1\nP1 = x\n');

    for k = 2:n
        coef(k+1, n-k+1:n+1) = conv([2*(k-1)+1, 0], coef(k, n-k+2:n+1)) - (k-1) * coef(k-1, n-k+1:n+1);
        coef(k+1, :) = coef(k+1, :) / k;
        fprintf('P%d = %s\n', k, char(poly2sym(coef(k+1, :))));
    end

    nCoef = coef(n+1, :);
end