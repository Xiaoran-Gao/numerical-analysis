clear all

f = @(x) 1 ./ (1 + x.^2);
df = @(x) -2 * x ./ (1+x.^2) .^ 2;
a = -5;
b = 5;
n = 10;
x = a:(b-a)/n:b;
y = f(x);
xh = a:(b-a)/500:b;

% 10次Lagrange插值多项式
yh1 = zeros(size(xh));
for k = 1:n+1
    fracVal = prod(x(k) - x([1:k-1, k+1:end]));
    for i = 1:length(xh)
        yh1(i) = yh1(i) + y(k) * prod(xh(i) - x([1:k-1, k+1:end])) / fracVal;
    end
end

% 三次样条插值多项式
df0 = df(a);
dfn = df(b);
yh2 = spline(x, [df0, y, dfn], xh);

figure;
hold on;
plot(xh, yh1);
plot(xh, yh2);
hold off;
legend('L10(x)', 'S(x)');