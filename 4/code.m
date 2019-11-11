set(0, 'defaultaxesfontsize', 14) 
set(0, 'defaulttextfontsize', 14)


% функции
F = {@(X) 2.^X - 2, @(X) 2.^-X - 2, @(X) -(2.^X - 2), @(X) -(2.^-X - 2)};
global X = linspace(-3, 3, 100);

Fm = {@bisection, @chord, @newton};

%% визуализация работы
%for i = 1:length(Fm)
%    for j = 1:4
%        subplot(2, 2, j);
%        box off;
%        hold on;
%        grid on;
%        set(gca, 'xaxislocation', 'origin');
%        set(gca, 'yaxislocation', 'origin');
%        plot(X, F{j}(X));
%        xlabel('x');
%        ylabel('y');
%
%        [xroot, yroot, n] = Fm{i}(F{j}, -2, 2.5, 0.2);
%        plot(xroot, yroot, 'bo', 'MarkerFaceColor', 'b');
%    end
%    figure;
%end

% зависимость кол-ва вычислений от точности
hold on;
E = linspace(0.00000001, 0.2, 20);
for i = 1:length(Fm)
    N = [];
    for e = E
        [xroot yroot n] = Fm{i}(F{1}, -2, 2.5, e);
        N = [N n];
    end
    plot(E, N);
end
legend('Половинного деления', 'Хорд', 'Ньютона');
xlabel('Погрешность')
ylabel('Вычислений')


pause
