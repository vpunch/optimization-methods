% вторая производная в точке

function [res, n] = der2(f, x0, h)
    n = 0;

    if nargin < 3
        h = 0.0001;
    end
    
    [d1, n1] = grad(f, x0, f(x0) h); n += n1;
    [d2, n1] = grad(f, x0 + h, f(x0 + h), h); n += n1;
    res = (d2 - d1) / h;
end
