clear all

x = [-2 -1 1 2];
y = [5 3 17 21];

disp(myDivDiff(x, y));

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