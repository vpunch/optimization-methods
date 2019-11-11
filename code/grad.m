% градиент функции многих переменных (или производная функции одной переменной) в точке

function [GX0, n] = grad(F, X0, h)
    y0 = F(X0); 
    ++n;

    if nargin < 4
        h = 0.0001;
    end

    n = 0;
    GX0 = [];
    for i = 1:length(X0)
        Xh = [X0(1:i-1), X0(i) + h, X0(i+1:end)];
        GX0 = [GX0, (F(Xh) - y0) / h];

        ++n;
    end
end
