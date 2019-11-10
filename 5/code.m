set(0, 'defaultaxesfontsize', 12) 
set(0, 'defaulttextfontsize', 12)


global C = [3 3 1 -7 -7]
global fu = @(x) C(1)*x(1)^2 - C(2)*x(1)*x(2) + C(3)*x(2)^2 - C(4)*x(1) + C(5)*x(2)

X1 = X2 = linspace(-10, 10, 40)';
[XX1, XX2] = meshgrid(X1, X2);

YY = [];
for i = 1:length(X1)
    Y = [];
    for j = 1:length(X2)
        Y = [Y, fu([X1(i) X2(j)])];
    end
    YY = [YY; Y];
end

% вывод графика
mesh(XX1, XX2, YY);
hold on
xlabel("x1");
ylabel("x2");
zlabel("y");

% начальное приближение
x0 = [1, -2];
%[xmin ymin] = fminunc(f, x0)

function [f, g] = fwithgrad(x)
    global C;
    global fu;
    f = fu(x);

    if nargout > 1
        % градиент функции
        g = [6*x(1) - 3*x(2) + 7;
            -3*x(1) + 2*x(2) - 7];
    end
end
options = optimset('GradObj', 'on');
[xmin, ymin] = fminunc(@fwithgrad, x0, options)

plot3(xmin(2), xmin(1), ymin, 'r.', 'MarkerSize', 40);

figure

contour(XX1, XX2, YY, 20)

pause
