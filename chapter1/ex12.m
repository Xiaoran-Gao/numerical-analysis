clear all

% 真实值
a0 = sum(1:40) + 10^16;
seq = [1:40, 10^16];

% 从小到大相加
a1 = sum(seq);

% 从大到小相加
a2 = sum(flip(seq));

err1 = abs(a1 - a0)
err2 = abs(a2 - a0)