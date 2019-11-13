% Copyright © 2019 Panchishin Ivan

% метод Ньютона
% Newton's method

% Approx - позволяет восстановить касательную

function [xroot, yroot, info] = newton(f, a, b, e)
    Ap = [a, f(a)];
    Bp = [b, f(b)];
    
    [d2, d2ncalc] = deriv2(f, Ap(1));
    if (d2 * Ap(2) < 0) % выбор начального приближения корня
        X0p = Bp;
    else
        X0p = Ap;
    end 

    [X1p, info] = newton_step(f, X0p, e);

    info.ncalc += 2 + d2ncalc;
    [xroot, yroot] = deal(X1p(1), X1p(2));
end 

function [X1p, info] = newton_step(f, X0p, e)
    [d1, d1ncalc] = grad(f, X0p(1));
    x1 = X0p(1) - X0p(2) / d1;
    X1p = [x1, f(x1)];

    info.nstep = 1;
    info.ncalc = 1 + d1ncalc;
    info.Approx = [X0p, d1];
    
    if (abs(X1p(1) - X0p(1)) <= e)
        return
    end 

    [X1p, info1] = newton_step(f, X1p, e);

    info.nstep += info1.nstep;
    info.ncalc += info1.ncalc;
    info.Approx = [info.Approx; info1.Approx];
end
