% метод Ньютона
function [xroot yroot n] = newton(f, a, b, e)
    Ap = [a f(a)];
    Bp = [b f(b)];
    n = 2;
    
    d2 = der2(f, Ap(1));
    if (d2 * Ap(2) > 0)
        [Xp n] = newton_step(f, Ap, e, n);
    else
        [Xp n] = newton_step(f, Bp, e, n);
    end 
    
    [xroot yroot] = deal(Xp(1), Xp(2));
end 

function [Xp n] = newton_step(f, Xp, e, n)
    d1 = der1(f, Xp(1), 0.001);
    x = Xp(1) - Xp(2) / d1;
    
    if (abs(x - Xp(1)) <= e)
        return
    end 
    
    ftang = @(X) d1 * (X - Xp(1)) + Xp(2);
    global X;
    %plot(X, ftang(X));
    
    Xp = [x f(x)];
    ++n; 
    
    [Xp n] = newton_step(f, Xp, e, n);
end
