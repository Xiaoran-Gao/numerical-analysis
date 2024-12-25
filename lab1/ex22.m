clear all

f = @(x) 1 ./ (1 + x.^2);
x = linspace(-5, 5, 100);
y = f(x);

p = polyfit(x, y, 15);

xInterp = linspace(-5, 5, 100);
yInterp = polyval(p, xInterp);

figure;
hold on;
plot(xInterp, yInterp);
plot(x, y);
hold off;

legend('插值多项式L', '原函数f');