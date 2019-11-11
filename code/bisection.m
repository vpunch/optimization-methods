% метод половинного деления
% будет работать бесконечно, если на отрезке нет корня
function [xroot yroot n] = bisection(f, a, b, e)
    Ap = [a f(a)]; % A point
    Bp = [b f(b)];
    n = 2;

    [Ap Bp n] = bisection_step(f, Ap, Bp, e, n); 

    xroot = (Ap(1) + Bp(1)) / 2;
    yroot = f(xroot);
end

function [Ap Bp n] = bisection_step(f, Ap, Bp, e, n)
    if (abs(Bp(1) - Ap(1)) <= e)
        return
    end

    c = (Ap(1) + Bp(1)) / 2;
    fc = f(c);
    ++n;

    % учтен случай, когда попадается корень
    if (fc * Ap(2) <= 0)
        Bp = [c fc];
    end

    if (fc * Bp(2) <= 0)
        Ap = [c fc];
    end

    [Ap Bp n] = bisection_step(f, Ap, Bp, e, n);
end
