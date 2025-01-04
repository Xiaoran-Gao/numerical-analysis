clear all

x = [27.7 28 29 30];
y = [4.1 4.3 4.1 3.0];
df0 = 3.0;
dfn = -4.0;

% 计算参数
n = length(x) - 1;
h = diff(x);
mu = h(1:n-1) ./ (h(1:n-1) + h(2:n));
lambda = 1 - mu;
divDiff1 = diff(y) ./ diff(x);
divDiff2 = diff(divDiff1) ./ (x(3:end) - x(1:end-2));
d = 6 * divDiff2;

A = 2 * eye(n+1) + diag([1; lambda(:)], 1) + diag([mu(:); 1], -1);
d0 = 6 * (divDiff1(1) - df0) / h(1);
dn = 6 * (dfn - divDiff1(end)) / h(end);
d = [d0; d(:); dn];
M = A \ d;

% 计算s_k(x)的系数
p = zeros(n, 4); % 每一行是一个区间，每个区间上的三次样条插值多项式有4个参数
for i = 1:n
    p(i, 1) = (M(i+1) - M(i)) / (6 * h(i));
    p(i, 2) = M(i) / 2;
    p(i, 3) = divDiff1(i) - (h(i) * (M(i+1) + 2 * M(i)) / 6);
    p(i, 4) = y(i);
end
fprintf('手动计算的系数矩阵：\n');
disp(p);

% 用spline函数计算s_k(x)
pp = spline(x, [df0, y, dfn]);
fprintf('spline函数计算的系数矩阵：\n');
disp(pp.coefs);