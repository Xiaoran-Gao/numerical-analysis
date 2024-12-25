clear all

f = @(x) 1 ./ (1 + x.^2);
df = @(x) -2 * x ./ (1+x.^2) .^ 2;
a = -5;
b = 5;
n = 10;
x = a:(b-a)/n:b;
y = f(x);
m = df(x);

xh = a:(b-a)/500:b; % 插值节点
yhL = zeros(size(xh));
yhH = zeros(size(xh));

% 分段线性插值
L1 = @(x, x0, x1, y0, y1) y0 * (x-x1) / (x0-x1) + y1 * (x-x0) / (x1-x0);

for i = 1:n
    idx = find(xh > x(i) & xh <= x(i+1));
    yhL(idx) = L1(xh(idx), x(i), x(i+1), y(i), y(i+1));
end

% 分段3次Hermite插值
H3 = @(x, x0, x1, y0, y1, m0, m1) ...
    y0 .* (1 + 2*(x-x0)./(x1-x0)) .* ((x-x1)./(x0-x1)).^2 + ...
    y1 .* (1 + 2*(x-x1)./(x0-x1)) .* ((x-x0)./(x1-x0)).^2 + ...
    m0 .* (x-x0) .* ((x-x1)./(x0-x1)).^2 + ...
    m1 .* (x-x1) .* ((x-x0)./(x1-x0)).^2;

for i = 1:n
    idx = find(xh > x(i) & xh <= x(i+1));
    yhH(idx) = H3(xh(idx), x(i), x(i+1), y(i), y(i+1), m(i), m(i+1));
end

figure;
hold on;
plot(xh, yhL, 'b-');
plot(xh, yhH, 'r-');
plot(xh, f(xh), 'k-');
plot(x, y, 'ok');
hold off;
legend('L1(x)', 'H3(x)', 'f(x)');