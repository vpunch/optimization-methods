% Copyright © 2019 Panchishin Ivan

% метод половинного деления
% bisection method

% будет работать бесконечно, если на отрезке нет корня
function [xroot, yroot, info] = bisection(f, a, b, e)
    Ap = [a f(a)];
    Bp = [b f(b)];

    [Ap, Bp, info] = bisection_step(f, Ap, Bp, e); 

    info.ncalc += 2;
    xroot = (Ap(1) + Bp(1)) / 2;
    yroot = f(xroot);
end

function [Ap, Bp, info] = bisection_step(f, Ap, Bp, e)
    if (abs(Bp(1) - Ap(1)) <= e)
        return
    end
    
    c = (Ap(1) + Bp(1)) / 2;
    fc = f(c);

    % учтен случай, когда попадается корень
    if (fc * Ap(2) <= 0)
        Bp = [c, fc];
    end

    if (fc * Bp(2) <= 0)
        Ap = [c, fc];
    end

    info.nstep = 1;
    info.ncalc = 1;

    [Ap, Bp, info1] = bisection_step(f, Ap, Bp, e);
    
    info.nstep += info1.nstep;
    info.ncalc += info1.ncalc;
end
