% Copyright © 2019 Panchishin Ivan

% метод Фибоначчи
% fibonacci method

function [xm, ym, info] = fibonacci(f, a, b, e)
    info.nstep = 0;
    info.ncalc = 3;
    info.Approx = [a, b];

    k = 0;
    while (b - a) / e > fibnum(++k) end
    
    right = @(a, b, k) a + fibnum(k - 1) / fibnum(k) * len(a, b);
    left = @(a, b, k) a + fibnum(k - 2) / fibnum(k) * len(a, b);
    
    [x1, x2] = deal(left(a, b, k), right(a, b, k));
    [y1, y2] = deal(f(x1), f(x2)); 

    while (k > 3) % последние числа 1/3 и 2/3
        if (y2 > y1)
            b = x2;
            [x2, y2] = deal(x1, y1);
            x1 = left(a, b, k);
            y1 = f(x1);
        else
            a = x1;
            [x1, y1] = deal(x2, y2);
            x2 = right(a, b, k);
            y2 = f(x2);
        end 

        --k;

        ++info.nstep;
        ++info.ncalc;
        info.Approx = [info.Approx; [a, b]];
    end 
    
    xm = (a + b) / 2;
    ym = f(xm);
end

function res = fibnum(n)
    if (n < 0)
        res = -1; 
    elseif (n == 0)
        res = 0;
    elseif (n == 1)
        res = 1;
    else
        res = fibnum(n - 1) + fibnum(n - 2); 
    end 
end
