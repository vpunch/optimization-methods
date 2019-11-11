% грубая локализация минимума

function [a, b, n] = minloc(f, x0, h)
    % направление убывания
    n = 2;
    while f(x0 + h) > f(x0)
        n += 2;
        if f(x0 - h) > f(x0)
            h = h / 2;
        else
            h = -h; 
            break
        end 
        
        n += 2;
    end 

    x1 = x0 + h;

    n += 2;
    while f(x1) <= f(x0) % движение к локальному экстр.
        x0 = x1;
        x1 = x1 + h;

        n += 2;
    end 

    x0 = x0 - h; % на случай, если перепрыгнули экстремум

    if x1 > x0, [a b] = deal(x0, x1);
    else [a b] = deal(x1, x0); end 
end
