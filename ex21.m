clear all

x = 0.4:0.1:0.8;
y = [-0.9163 -0.6931 -0.5108 -0.3567 -0.2231];
xh = 0.54;

% 真实值
yhReal = log(xh);

% 线性插值
yh1 = myInterp(x, y, 1, xh);

% 抛物线插值
yh2 = myInterp(x, y, 2, xh);

function yh = myInterp(x, y, k, xh)
    % x：插值节点
    % y：插值节点对应的函数值
    % k：插值多项式的次数
    % xh：需要计算插值函数值的节点
    % yh：xh处对应的插值函数值

    [~, idx] = sort(abs(xh - x));
    xInterp = x(idx(1:k+1));
    yInterp = y(idx(1:k+1));
    yh = 0;
    l = ones(1, k+1);

    for i = 1:k+1
        for j = 1:k+1
            if j ~= i
                 l(i) = l(i) * (xh - xInterp(j)) / (xInterp(i) - xInterp(j));
            end
        end
        yh = yh + yInterp(i) * l(i);
    end
end