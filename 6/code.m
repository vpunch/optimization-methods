set(0, 'defaultaxesfontsize', 12) 
set(0, 'defaulttextfontsize', 12)


function [GX0, n] = grad(f, X0, y0, n)
    h = 0.0001;
    GX0 = [(f([X0(1) + h, X0(2)]) - y0) / h];
    GX0 = [GX0, (f([X0(1), X0(2) + h]) - y0) / h];
    n += 2;
end

function [Xm, ym, n, Approx] = graddesc(f, X0, h, e)
    n = 0;
    y0 = f(X0);
    Approx = [];
    [Xm, ym, n, Approx] = graddesc_step(f, X0, y0, h, e, n, Approx);
end

function [Xm, ym, n, Approx] = graddesc_step(f, X0, y0, h, e, n, Approx)
    Approx = [Approx; [X0, y0]];

    GX0 = grad(f, X0, y0, n);

    % проверяем критерий останова
    if sqrt(GX0(1)^2 + GX0(2)^2) <= e
        Xm = X0;
        ym = f(Xm); ++n;
        return
    end

    while true
        % перемещение точки вдоль антиградиента
        X1 = X0 - GX0*h;

        y1 = f(X1); ++n;
        if (y1 < y0)
            X0 = X1;
            y0 = y1;
            break;
        end
        
        h = h/2;
    end

    [Xm, ym, n, Approx] = graddesc_step(f, X0, y0, h, e, n, Approx);
end


% исходные данные
f = @(X) 3*X(1)^2 - 3*X(1)*X(2) + X(2)^2 + 7*X(1) - 7*X(2);
X1 = X2 = linspace(-10, 10, 50)';
[XX1, XX2] = meshgrid(X1, X2);

YY = []; 
for i = 1:length(X1)
    Y = []; 
    for j = 1:length(X2)
        Y = [Y, f([X1(i) X2(j)])];
    end 
    YY = [YY; Y]; 
end

% вывод графика
surf(XX1, XX2, YY, 'edgecolor', 'none');
hold on
xlabel("x1");
ylabel("x2");
zlabel("y");

% поиск минимума 
X0 = [1 -2];
[Xm ym] = fminunc(f, X0)
plot3(Xm(2), Xm(1), ym, 'b.', 'MarkerSize', 40);

[Xm, ym, n, Approx] = graddesc(f, X0, 1, 0.8); n
plot3(Xm(2), Xm(1), ym, 'r.', 'MarkerSize', 40);
plot3(Approx(:, 2), Approx(:, 1), Approx(:, 3), 'r', 'LineWidth', 3);

% количество вычислений в зависимости от масштаба (шага)
figure;
H = linspace(0.05, 1, 6);
for i = 1:length(H)
    subplot(2, 3, i);
    contour(XX1, XX2, YY, 20);
    hold on;

    [Xm, ym, n, Approx] = graddesc(f, X0, H(i), 0.8);
    plot(Xm(2), Xm(1), 'r.', 'MarkerSize', 20);
    plot(Approx(:, 2), Approx(:, 1), 'r', 'LineWidth', 3);
    title(['Шаг ', num2str(H(i)), ', Вычислений ', num2str(n)]);
end


pause
