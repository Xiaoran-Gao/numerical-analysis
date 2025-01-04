clear all

x = [0.5 0.6 0.4];
y = [-0.6931 -0.5108 -0.9163];
xh = 0.54;
newtonCoef = diag(myDivDiff(x, y));

% Newton线性插值
yh1 = newtonCoef(1) + newtonCoef(2) * (xh - x(1));

% Newton抛物线插值
yh2 = newtonCoef(1) + newtonCoef(2) * (xh - x(1)) + newtonCoef(3) * (xh - x(1)) * (xh - x(2));

function mat = myDivDiff(x, y)
    % x：插值节点
    % y：插值节点对应的函数值

    mat = zeros(length(x), length(x));
    mat(:, 1) = y';
    for i = 2:length(x)
        for k = 2:i
            mat(i, k) = (mat(i, k-1) - mat(i-1, k-1)) ./ (x(i) - x(i-k+1));
        end
    end
end