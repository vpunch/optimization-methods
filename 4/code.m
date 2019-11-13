addpath('../code')

set(0, 'defaultaxesfontsize', 14) 
set(0, 'defaulttextfontsize', 14)


% функции
%F = {@(X) 2.^X - 2, @(X) 2.^-X - 2, @(X) -(2.^X - 2), @(X) -(2.^-X - 2)};
F = {@(X) 2.^X - 2};
global X = linspace(-3, 3, 100);
%
Fm = {@secant}; 

% визуализация работы
for i = 1:length(Fm)
    for j = 1
        subplot(2, 2, j);
        box off;
        hold on;
        grid on;
        set(gca, 'xaxislocation', 'origin');
        set(gca, 'yaxislocation', 'origin');
        plot(X, F{j}(X));
        xlabel('x');
        ylabel('y');
        %ftang = @(Xp, d1) d1 * (X - Xp(1)) + Xp(2);
        fchord = @(Xp, Bp) (Xp(2) - Bp(2)) / (Xp(1) - Bp(1)) * (X - Xp(1)) + Xp(2);
        [xroot, yroot, info] = Fm{i}(F{j}, -2, 2.5, 0.8)
        plot(xroot, yroot, 'bo', 'MarkerFaceColor', 'b');
        for row = info.Approx'
            %plot(X, ftang([row(1), row(2)], row(3)));
            plot(X, fchord([row(1), row(2)], [row(3), row(4)]));
        end
    end
    figure;
end
%
%% зависимость кол-ва вычислений от точности
%hold on;
%E = linspace(0.00000001, 0.2, 20);
%for i = 1:length(Fm)
%    N = [];
%    for e = E
%        [xroot yroot n] = Fm{i}(F{1}, -2, 2.5, e);
%        N = [N n];
%    end
%    plot(E, N);
%end
%legend('Половинного деления', 'Хорд', 'Ньютона');
%xlabel('Погрешность')
%ylabel('Вычислений')
%
% 
%    global X;
%    % раскомментировать для визуализации
%    %plot(X, fchord(X));
%
%
%    
%    global X;
%    %plot(X, ftang(X));

pause
