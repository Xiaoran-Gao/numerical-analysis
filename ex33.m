clear all

f = @(x) 1 ./ (1 + x.^2);
a = -5;
b = 5;
n = 10; % 插值次数

% 等距节点
xh1 = a:(b-a)/n:b;
yh1 = f(xh1);

% Chebyshev节点
xh2 = 5 * cos(((2 * [0:n] + 1) / (2 * (n+1))) * pi);
yh2 = f(xh2);

% 真实值
x = a:0.01:b;
y = f(x);

y1 = zeros(size(x));
y2 = zeros(size(x));

% 计算n次插值的结果
for k = 1:n+1
    fracVal1 = prod(xh1(k) - xh1([1:k-1, k+1:n+1]));
    fracVal2 = prod(xh2(k) - xh2([1:k-1, k+1:n+1]));
    for j = 1:length(x)
        y1(j) = y1(j) + yh1(k) * prod(x(j) - xh1([1:k-1, k+1:n+1])) / fracVal1;
        y2(j) = y2(j) + yh2(k) * prod(x(j) - xh2([1:k-1, k+1:n+1])) / fracVal2;
    end
end

plot(x, y, 'k-', x, y1, 'b--', x, y2, 'r--');
legend('真实值', '等距节点插值', 'Chebyshev节点插值');