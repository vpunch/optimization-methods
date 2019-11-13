addpath('../code')

set(0, 'defaultaxesfontsize', 14)
set(0, 'defaulttextfontsize', 14)


% целевые функции
F = {@(X) 2.^X - 2, @(X) 2.^-X - 2, @(X) -(2.^X - 2), @(X) -(2.^-X - 2)};
% область определения целевой функции
X = linspace(-3, 3, 100);
% методы приближенного поиска корня
M = {@bisection, @secant, @newton}; 
Name = {'Половинного деления', 'Хорд', 'Ньютона'};


% хорда
fchord = @(Xp, Bp, X) (Xp(2) - Bp(2)) / (Xp(1) - Bp(1)) * (X - Xp(1)) + Xp(2);
% касательная
ftang = @(Xp, d1, X) d1 * (X - Xp(1)) + Xp(2);

% поиск корня
for i = 1:length(M)
    for j = 1:length(F)
        subplot(2, 2, j);
        box off;
        hold on;
        grid on;
        set(gca, 'xaxislocation', 'origin');
        set(gca, 'yaxislocation', 'origin');
        xlabel('x');
        ylabel('y');
        plot(X, F{j}(X));
        
        [xroot, yroot, info] = M{i}(F{j}, -2, 2.5, 0.3)
        title([Name{i} ', Шагов ' num2str(info.nstep) ', Вычислений ' num2str(info.ncalc)]);
        plot(xroot, yroot, 'ro', 'MarkerFaceColor', 'r');

        if (i == 2)
            for Approx = info.Approx'
                plot(X, fchord(Approx(1:2), Approx(3:4), X));
            end
        end
        if (i == 3)
            for Approx = info.Approx'
                plot(X, ftang(Approx(1:2), Approx(3), X));
            end
        end
    end
    figure
end


% зависимость кол-ва вычислений от точности
hold on;
E = linspace(0.001, 0.5, 100);
for i = 1:length(M)
    N = [];
    for e = E
        [_, _, info] = M{i}(F{1}, -2, 2.5, e);
        N = [N, info.ncalc];
    end
    plot(E, N);
end
legend(Name);
xlabel('Погрешность')
ylabel('Вычислений')


pause
