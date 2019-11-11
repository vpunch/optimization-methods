% метод Фибоначчи

% см. dichotomy.m для описания аргументов

function [xm, ym, n, Approx] = fib(f, a, b, e)
    Approx = [a, b];

    minfib = (b - a) / e;
    k = 1; 
    while minfib > fibonacci(k)
        ++k;
    end 
    
    right = @(a, b, k) a + fibonacci(k-1) / fibonacci(k) * len(a, b);
    left = @(a, b, k) a + fibonacci(k-2) / fibonacci(k) * len(a, b);
    
    [x1 x2] = deal(left(a, b, k), right(a, b, k));
    [y1 y2] = deal(f(x1), f(x2)); 
    n = 2;
    
    while k > 2
        ++n;
        if (y2 > y1)
            b = x2;
            [x2 y2] = deal(x1, y1);
            x1 = left(a, b, k);
            y1 = f(x1);
        else
            a = x1;
            [x1 y1] = deal(x2, y2);
            x2 = right(a, b, k);
            y2 = f(x2);
        end 

        Approx = [Approx; [a, b]];

        --k;
    end 
    
    xm = (a + b) / 2;
    ym = f(xm); ++n;
end

function res = fibonacci(n)
    if n < 0 
        res = -1; 
    elseif n == 0
        res = 0;
    elseif n == 1
        res = 1;
    else
        res = fibonacci(n - 1) + fibonacci(n - 2); 
    end 
end
