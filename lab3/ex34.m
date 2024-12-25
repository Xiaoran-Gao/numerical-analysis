clear all

x = [0 0.5 0.6 0.7 0.8 0.9 1.0];
y = [1.00 1.75 1.96 2.19 2.44 2.71 3.00];
omega = [1 1 1 1 1 1 1];

n = 2;
P = cell(1, n+2);
P{2} = 1;
a = zeros(1, n+1);
alpha = 0;
beta = 0;

% 计算正交多项式
for k = 1:n
    Pk = polyval(P{k+1}, x);
    alpha = dot(omega .* x .* Pk, Pk) / dot(omega .* Pk, Pk); 
    if k > 1
        PkPrev = polyval(P{k}, x);
        beta = dot(omega .* Pk, Pk) / dot(omega .* PkPrev, PkPrev); 
    end
    P{k+2} = conv([1, -alpha], P{k+1}) - beta * [0, 0, P{k}];
    a(k) = dot(omega .* y, Pk) / dot(omega .* Pk, Pk);
end

Pk = polyval(P{n+2}, x);
a(n+1) = dot(omega .* y, Pk) / dot(omega .* Pk, Pk);

P(1) = [];

% 最小二乘拟合函数
poly = a(1) * P{1};
for k = 1:n
    poly = [0, poly] + a(k+1) * P{k+1};
end
fprintf('%d次最小二乘拟合多项式：%s\n', n, char(poly2sym(poly)));

% 误差
yh = polyval(poly, x);
err = sqrt(dot(omega .* (yh-y), (yh-y))) ^ 2;
fprintf('以上多项式的拟合误差：%.2e\n', err);