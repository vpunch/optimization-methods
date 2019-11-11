% метод хорд
function [xroot yroot n] = chord(f, a, b, e)
    Ap = [a f(a)];
    Bp = [b f(b)];
    n = 2;

    d2 = der2(f, Ap(1));
    if (d2 * Ap(2) > 0) % выбор начального приближения корня
        [Xp n] = chord_step(f, Bp, Ap, e, n);
    else
        [Xp n] = chord_step(f, Ap, Bp, e, n);
    end

    [xroot yroot] = deal(Xp(1), Xp(2));
end

function [Xp n] = chord_step(f, Xp, Bp, e, n)
    x = Xp(1) - Xp(2) * (Xp(1) - Bp(1)) / (Xp(2) - Bp(2));

    if (abs(x - Xp(1)) <= e)
        return
    end

    fchord = @(X) (Xp(2) - Bp(2)) / (Xp(1) - Bp(1)) * (X - Xp(1)) + Xp(2);
    global X;
    % раскомментировать для визуализации
    %plot(X, fchord(X));

    Xp = [x f(x)];
    ++n;

    [Xp n] = chord_step(f, Xp, Bp, e, n);
end
