clear all

x = 0:0.1:0.4;
y = cos(x);
n = 4;
h = 0.1;
xh = 0.048;
t = (xh - x(1)) / h;
coef = myDiff(x, y);
coef = coef(1, :);

yh = y(1);
for i = 1:n
    yh = yh + prod(t-i+1:t) / factorial(i) * coef(i+1);
end

err = prod(t-n:t) * h^(n+1) / factorial(n+1) * sin(x(end));


function mat = myDiff(x, y)
    % x：插值节点
    % y：插值节点对应的函数值

    mat = zeros(length(x), length(x));
    mat(:, 1) = y';
    for k = 1:(length(x)-1)
        mat(1:length(x)-k, k+1) = diff(mat(1:length(x)-k+1, k));
    end
end