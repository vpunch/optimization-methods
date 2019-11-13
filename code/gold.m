% Copyright © 2019 Panchishin Ivan

% метод золотого сечения
% golden-section method

function [xm, ym, info] = gold(f, a, b, e)
    info.nstep = 0;
    info.ncalc = 3;
    info.Approx = [a, b];

    g = (sqrt(5) - 1) / 2;
    right = @(a, b) a + g * len(a, b);
    left = @(a, b) a + (1 - g) * len(a, b);
    
    [x1 x2] = deal(left(a, b), right(a, b));
    [y1 y2] = deal(f(x1), f(x2));
    
    % точность для произвольной итерации
    %initLen = b - a; 
    %1/2 * g^n * initLen
    
    while ((b - a) / 2 > e)
        if (y2 > y1)
            b = x2;
            [x2, y2] = deal(x1, y1);
            x1 = left(a, b);
            y1 = f(x1);
        else
            a = x1;
            [x1, y1] = deal(x2, y2);
            x2 = right(a, b);
            y2 = f(x2);
        end 

        ++info.nstep;
        ++info.ncalc;
        info.Approx = [info.Approx; [a, b]];
    end 
    
    xm = (a + b) / 2;
    ym = f(xm);
end
