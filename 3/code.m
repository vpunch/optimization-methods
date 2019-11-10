set(0, 'defaultaxesfontsize', 12) 
set(0, 'defaulttextfontsize', 12)


% грубая локализация минимума
function [a b] = minloc(f, x0, h)
    % направление убывания
    while f(x0 + h) > f(x0)
        if f(x0 - h) > f(x0)
            h = h / 2;
        else
            h = -h;
            break
        end
    end

    x1 = x0 + h;

    while f(x1) <= f(x0) % движение к локальному экстр.
        x0 = x1;
        x1 = x1 + h;
    end

    x0 = x0 - h;

    if x1 > x0, [a b] = deal(x0, x1);
    else [a b] = deal(x1, x0); end
end

% метод парабол
function [xm, ym] = parab(f, a, b, e)
    % точки пересечений
    [x1 x3] = minloc(f, a, 0.2); %или a b
    x2 = x1 + (x3 - x1) * rand(); %(a + b) / 2

    [y1 y2 y3] = deal(f(x1), f(x2), f(x3));
    n = 3;

    % интерполяционный квадратный многочлен Ньютона
    g = @(a0, a1, a2, x1, x2, X) a0 + a1 * (X - x1) + a2 * (X - x1) .* (X - x2);

    x42 = NaN;
    x41 = NaN;
    while true
        ++n;

        a0 = y1;
        a1 = (y2 - y1) / (x2 - x1);
        a2 = 1 / (x3 - x2) * ((y3 - y1) / (x3 - x1) - (y2 - y1) / (x2 - x1));

        % строим параболу
        X = linspace(0, 1, 100);
        plot(X, g(a0, a1, a2, x1, x2, X), 'Color', 'r');
        pause(1);

        x42 = x41;
        % минимум параболы
        x41 = 1/2 * (x1 + x2 - a1/a2);

        if (x41 > x2)
            [x1 y1] = deal(x2, y2);
            [x2 y2] = deal(x41, f(x41));
        else
            [x1 y1] = deal(x41, f(x41));
        end

        if (!isnan(x42) && abs(x41 - x42) <= e)
            break;
        end
    end

    xm = x41;
    ym = f(xm);
end


% исходные данные
f = @(X) X.^4 + exp(-X)
X = linspace(0, 1, 100);
[a b] = deal(0, 1)
e = 0.01

% вывод функции
plot(X, f(X), 'Color', 'b');
xlabel('x');
ylabel('y');
hold on;

% минимум
xm = fminbnd(f, a, b)
ym = f(xm);
plot(xm, ym, 'bo', 'LineWidth', 3);

[xm ym] = parab(f, a, b, e);
plot(xm, ym, 'ro', 'LineWidth', 3);


pause
