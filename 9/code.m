% Copyright © 2019 Panchishin Ivan

addpath('../code')

set(0, 'defaultaxesfontsize', 14);
set(0, 'defaulttextfontsize', 14);

% количество полигонов поверхности
density = 50;



% исходные данные
F = @(X) 1/X(1) + 1/X(2);%X(1)^2 + X(2)^2 - X(1)*X(2) - X(1) - X(2);
X1 = linspace(-4, 4, density)';
X2 = linspace(-4, 4, density)';
[XX1, XX2] = meshgrid(X1, X2);

YY = []; 
for i = 1:length(X1)
    Y = []; 
    for j = 1:length(X2)
        Y = [Y, F([X1(i) X2(j)])];
    end 
    YY = [YY; Y]; 
end

subplot(1, 2, 1);
surf(XX1, XX2, YY);
hold on

subplot(1, 2, 2);
hold on



% секущие плоскости
% функции (g)
GX2 = {
    linspace(-1, 3, density), @(x1) 2 - x1
}; 

% прямые
GG = {
%    ones(1, density)*0 linspace(0, 3, density);
%    linspace(0, 3, density) ones(1, density)*0
};
for Gx2 = GX2'
    X = Gx2{1};
    GG = [GG; {X, Gx2{2}(X)}];
end

for G = GG'
    XX1_cond = [];
    XX2_cond = [];
    YY_cond = [];

    for i = 1:length(G{1})
        Row = ones(1, length(G{2}));
        XX1_cond = [XX1_cond; Row * G{1}(i)];
        XX2_cond = [XX2_cond; Row * G{2}(i)];
        YY_cond = [YY_cond; linspace(-50, 50, length(G{2}))]; % нижняя и верхняя граница секущей
    end
    
    subplot(1, 2, 1);
    surf(XX1_cond, XX2_cond, YY_cond);%, 'facecolor', 'red', 'edgecolor', 'none', 'facealpha', 0.5);


    subplot(1, 2, 2);

    % косинус угла наклона прямой
    cosin = (G{1}(2) - G{1}(1)) / sqrt((G{1}(2) - G{1}(1))^2 + (G{2}(2) - G{2}(1))^2);

    Flatg = G{1} / cosin; % ось, образованная прямой
    Flaty = [];
    for i = 1:density
        Flaty = [Flaty, F([G{1}(i) G{2}(i)])];
    end

    plot(G{1}, Flaty, 'color', 'blue');
    plot(Flatg, Flaty, 'color', 'red');
end



subplot(1, 2, 1);
xlabel('x1');
ylabel('x2');
zlabel('y');

subplot(1, 2, 2);
legend('X', 'GX');
xlabel('x');
ylabel('y');

pause
