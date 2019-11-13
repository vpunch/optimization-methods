addpath('../code');

set(0, 'defaultaxesfontsize', 14);
set(0, 'defaulttextfontsize', 14);


% целевая функция
f = @(X) X.^4 + exp(-X)
% область определения
X = -1:0.01:1;
% отрезок поиска
[a b] = deal(-0.5, 1)
e = 0.1

% минимум
[targetxm, targetym] = fminbnd(f, a, b)

M = {@dichotomy, @gold, @fibonacci};
Name = {'Дихотомии', 'Золотого сечения', 'Фибоначчи'};


% поиск минимума

for i = 1:length(M)
    subplot(1, 3, i);

    plot(X, f(X), 'Color', 'b');
    xlabel('x');
    ylabel('y');
    hold on;

    plot(targetxm, targetym, 'bo', 'LineWidth', 3);


    [xm, ym, info] = M{i}(f, a, b, e);
    title([Name{i} ', Шагов ' num2str(info.nstep) ', Вычислений ' num2str(info.ncalc)]);

    segment = plot([info.Approx(1, 1) info.Approx(1, 2)], [0 0], 'Color', 'r', 'LineWidth', 3);
    for j = 1:length(info.Approx) - 1
        st = info.Approx(j, :);
        en = info.Approx(j+1, :);
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

E = linspace(0.0001, 0.2, 100);
for i = 1:length(M)
    N = [];
    for e = E
        [xm ym info] = M{i}(f, a, b, e);
        N = [N info.ncalc];
    end
    plot(E, N);
end

legend(Name);
xlabel('Погрешность');
ylabel('Вычислений');


pause
