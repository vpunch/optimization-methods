% Copyright © 2019 Panchishin Ivan

% градиент функции многих переменных (или производная функции одной переменной) в точке
% function gradient value

function [Gx0, ncalc] = grad(F, X0, h)
    y0 = F(X0);
    ncalc = 1;

    if (nargin < 3)
        h = 0.001;
    end

    Gx0 = [];
    for i = 1:length(X0)
        Xh = [X0(1:i-1), X0(i) + h, X0(i+1:end)];
        Gx0 = [Gx0, (F(Xh) - y0) / h];
        ++ncalc;
    end
end
