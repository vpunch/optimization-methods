addpath('../code')

set(0, 'defaultaxesfontsize', 14);
set(0, 'defaulttextfontsize', 14);


% исходные данные
F = @(X) 3*X(1)^2 - 3*X(1)*X(2) + X(2)^2 + 7*X(1) - 7*X(2);
X1 = X2 = linspace(-10, 10, 50)';
[XX1, XX2] = meshgrid(X1, X2);

YY = []; 
for i = 1:length(X1)
    Y = []; 
    for j = 1:length(X2)
        Y = [Y, F([X1(i) X2(j)])];
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
[Xm ym] = fminunc(F, X0)
plot3(Xm(2), Xm(1), ym, 'b.', 'MarkerSize', 40);

gradparams = struct(
    'h', 1);
[Xm, ym, n, Approx] = graddesc(F, X0, 0.5, 'primal', gradparams)
plot3(Xm(2), Xm(1), ym, 'r.', 'MarkerSize', 40);
plot3(Approx(:, 2), Approx(:, 1), Approx(:, 3), 'r', 'LineWidth', 3);


% количество вычислений в зависимости от масштаба (шага)
figure;
H = linspace(0.05, 0.8, 6);
for i = 1:length(H)
    subplot(2, 3, i);
    contour(XX1, XX2, YY, 20);
    hold on;

    [Xm, ym, n, Approx] = graddesc(F, X0, 0.5, H(i));
    plot(Xm(2), Xm(1), 'r.', 'MarkerSize', 20);
    plot(Approx(:, 2), Approx(:, 1), 'r', 'LineWidth', 3);
    title(['Шаг ', num2str(H(i)), ', Вычислений ', num2str(n)]);
end


pause
