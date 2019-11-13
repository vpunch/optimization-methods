% Copyright © 2019 Panchishin Ivan

% метод хорд
% secant method

% Approx - позволяет восстановить хорду

function [xroot, yroot, info] = secant(f, a, b, e)
    Ap = [a, f(a)];
    Bp = [b, f(b)];

    [d2, d2ncalc] = deriv2(f, Ap(1))
    if (d2 * Ap(2) < 0)
        X0p = Ap;
    else
        X0p = Bp;
        Bp = Ap;
    end

    [X1p, info] = secant_step(f, X0p, Bp, e);

    info.ncalc += 2 + d2ncalc;
    [xroot, yroot] = deal(X1p(1), X1p(2));
end

function [X1p, info] = secant_step(f, X0p, Bp, e)
    x1 = X0p(1) - X0p(2) * (X0p(1) - Bp(1)) / (X0p(2) - Bp(2));
    X1p = [x1, f(x1)];

    info.nstep = 1;
    info.ncalc = 1;
    info.Approx = [X0p, Bp];
    
    if (abs(X1p(1) - X0p(1)) <= e)
        return
    end

    [X1p, info1] = secant_step(f, X1p, Bp, e);

    info.nstep += info1.nstep;
    info.ncalc += info1.ncalc;
    info.Approx = [info.Approx; info1.Approx];
end
