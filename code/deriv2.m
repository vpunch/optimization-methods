% Copyright © 2019 Panchishin Ivan

% вторая производная в точке
% second derivative value

function [res, ncalc] = deriv2(f, x0, h)
    if (nargin < 3)
        h = 0.001;
    end
    
    [d, ncalc] = grad(f, x0, h);
    [dh, ncalc1] = grad(f, x0 + h, h);
    ncalc += ncalc1;

    res = (dh - d) / h;
end
