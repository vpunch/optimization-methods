% Copyright © 2019 Panchishin Ivan

% грубая локализация минимума
% rough minimum localization

function [a, b, ncalc] = minloc(f, x0, h)
    ncalc = 2;

    % определяем направление убывания
    y0 = f(x0);
    while (f(x0 + h) > y0)
        ++ncalc;
        if f(x0 - h) > y0
            h = h / 2;
        else
            h = -h; 
            break
        end 
        
        ++ncalc;
    end 

    x1 = x0 + h;
    y1 = f(x1);

    while y1 <= y0 % движение к локальному экстр.
        x0 = x1;
        y0 = y1;

        x1 = x1 + h;
        y1 = f(x1);
        ++ncalc;
    end 

    x0 = x0 - h; % на случай, если перепрыгнули экстремум

    if x1 > x0, [a b] = deal(x0, x1);
    else [a b] = deal(x1, x0); end 
end
