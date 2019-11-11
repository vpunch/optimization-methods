% метод дихотомии

% f - функция одной переменной
% a, b - точки, определяющие отрезок поиска минимума
% e - характеристика точности (чем меньше, тем точнее)

% Xm - точка минимума
% ym - минимум
% n - кол-во вычислений целевой функции (f)
% Approx - история приближения

function [xm, ym, n, Approx] = dichotomy(f, a, b, e)
    Approx = [a, b];
    d = e; %rand() * 2 * e;
    n = 0;

    while (b - a) / 2 > e
        [x1 x2] = deal((a + b - d) / 2, (a + b + d) / 2);

        n = n + 2;
        if (f(x2) > f(x1))
            b = x2;
        else
            a = x1;
        end

        Approx = [Approx; [a, b]];
    end

    xm = (a + b) / 2;
    ym = f(xm); ++n;
end
