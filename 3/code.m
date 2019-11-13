set(0, 'defaultaxesfontsize', 14);
set(0, 'defaulttextfontsize', 14);


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
ym = f(xm)
plot(xm, ym, 'bo', 'LineWidth', 3);


[xm ym info] = parab(f, a, b, e)
title(['Парабол, Шагов ', num2str(info.nstep), ', Вычислений ', num2str(info.ncalc)]);

% строим параболы

% интерполяционный квадратный многочлен Ньютона
g = @(a0, a1, a2, x1, x2, X) a0 + a1 * (X - x1) + a2 * (X - x1) .* (X - x2);

for Coef = info.Approx' % итерация по строкам матрицы
    plot(X, g(Coef(1), Coef(2), Coef(3), Coef(4), Coef(5), X), 'Color', 'r');
    pause(1);
end

plot(xm, ym, 'ro', 'LineWidth', 3);


pause
