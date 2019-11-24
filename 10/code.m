% Copyright © 2019 Panchishin Ivan

addpath('../code')

set(0, 'defaultaxesfontsize', 14);
set(0, 'defaulttextfontsize', 14);


% исходные данные
F = @(X) X(1)^2 + X(2)^2 - X(1)*X(2) - X(1) - X(2);
G = {
    @(X) -X(1) + 3,
    @(X) -X(2) - 1,
    @(X) X(1)*3/2 + X(2) - 5
};


% контур
levels = [-2 -1 0 1 2 5 10 15 20 25 30];

[XX1, XX2, YY] = fungrid(F, -2, 5, 50);
c = contour(XX1, XX2, YY, levels, 'b--', 'DisplayName', 'Целевая функция');
hold on
grid on

[XX1, XX2, YY] = fungrid(@(X) penalty(F, G, X, 1), -2, 5, 50);
contour(XX1, XX2, YY, levels, 'r', 'DisplayName', 'Функция штрафов');

% ограничивающая область
plot([3, 3, 4, 3], [-1, 1, -1, -1], 'k');


% применение метода
R = [1 2 5 10 20 50 100 1000 10000 100000 1000000];

% внешняя точка
Hist = [4, 4.5];
gradparams = struct('a', -10, 'b', 10);
for r = R
    [X0, ym] = graddesc(@(X) penalty(F, G, X, r), Hist(end, :), 0.1, 'coord', gradparams);
    Hist = [Hist; X0];
end
plot(Hist(:, 1), Hist(:, 2), 'g*-', 'DisplayName', 'Путь внешней точки');

% внутренняя
Hist = [3.75, -0.95];
gradparams = struct('h', 1);
for r = [50, 100, 1000, 10000]
    [Xm, ym] = graddesc(@(X) penalty(F, G, X, r, 'interior'), Hist(end, :), 0.5, 'primal', gradparams);
    Hist = [Hist; X0];
end
plot(Hist(:, 1), Hist(:, 2), 'm*-', 'DisplayName', 'Путь внутренней точки');


title('Метод штрафных функций');
xlabel('x1');
ylabel('x2');
legend

pause
