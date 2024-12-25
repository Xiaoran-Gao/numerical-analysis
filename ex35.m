clear all

x = [0 0.1 0.2 0.3 0.5 0.8 1.0];
y = [1.00 0.41 0.50 0.61 0.91 2.02 2.46];
omega = [1 1 2 1 5 1 1];

poly2 = myPolyfit(x, y, omega, 2);
fprintf('2次最小二乘拟合多项式的系数：\n');
disp(poly2);
yh2 = polyval(poly2, x);
err2 = sqrt(dot(omega .* (yh2-y), (yh2-y))) ^ 2;
fprintf('以上多项式的拟合误差：%.2e\n', err2);

fprintf('\n');

poly3 = myPolyfit(x, y, omega, 3);
fprintf('3次最小二乘拟合多项式的系数：\n');
disp(poly3);
yh3 = polyval(poly3, x);
err3 = sqrt(dot(omega .* (yh3-y), (yh3-y))) ^ 2;
fprintf('以上多项式的拟合误差：%.2e\n', err3);

fprintf('\n');

poly4 = myPolyfit(x, y, omega, 4);
fprintf('4次最小二乘拟合多项式的系数：\n');
disp(poly4);
yh4 = polyval(poly4, x);
err4 = sqrt(dot(omega .* (yh4-y), (yh4-y))) ^ 2;
fprintf('以上多项式的拟合误差：%.2e\n', err4);

function poly = myPolyfit(x, y, omega, n)
    % 计算n次最小二乘拟合多项式

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
end