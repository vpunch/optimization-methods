addpath('../code');

set(0, 'defaultaxesfontsize', 14);
set(0, 'defaulttextfontsize', 14);


% исходные данные
f = @(X) X.^4 + exp(-X)
X = -1:0.01:1;
[a b] = deal(-0.5, 1)
e = 0.1

% минимум
[targetxm, targetym] = fminbnd(f, a, b)


% работа алгоритмов
Fm = {@dichotomy, @gold, @fib};
Name = {'Дихотомии', 'Золотого сечения', 'Фибоначчи'};

for i = 1:length(Fm)
    subplot(1, 3, i);

    plot(X, f(X), 'Color', 'b');
    xlabel('x');
    ylabel('y');
    hold on;

    plot(targetxm, targetym, 'bo', 'LineWidth', 3);


    [xm, ym, n, Approx] = Fm{i}(f, a, b, e)
    title([Name{i}, ', n = ', num2str(n)]);

    segment = plot([Approx(1, 1) Approx(1, 2)], [0 0], 'Color', 'r', 'LineWidth', 3);
    for j = 1:length(Approx) - 1
        st = Approx(j, :);
        en = Approx(j+1, :);
        if st(1) != en(1) 
            shinkseg(st(1), en(1), segment, 1);
        end
        if st(2) != en(2) 
            shinkseg(st(2), en(2), segment, 1);
        end
    end

    plot(xm, ym, 'ro', 'LineWidth', 3); 
end

% зависимость от точности
figure;
hold on;

E = linspace(0.0001, 0.5, 20);
for i = 1:length(Fm)
    N = [];
    for e = E
        [xm ym n] = Fm{i}(f, a, b, e);
        N = [N n];
    end
    plot(E, N);
end

legend(Name);
xlabel('Погрешность');
ylabel('Вычислений');


pause
