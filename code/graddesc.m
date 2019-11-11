% градиентный спуск

% F - функция нескольких переменных
% X0 - начальное приближение (к точке минимума)
% e - характеристика точности (чем меньше, тем точнее)
% type - тип спуска
% params - дополнительные параметры, которые зависят от типа спуска

% Xm - точка минимума
% ym - минимум
% n - кол-во вычислений целевой функции (F)
% Approx - история приближения

function [Xm, ym, n, Approx] = graddesc(F, X0, e, type, params)
    %figure
    y0 = F(X0); n = 1;
    Approx = []; 

    switch type
        case 'primal'
            [Xm, ym, n, Approx] = graddesc_h(F, X0, y0, e, n, Approx, NaN);
            return
        case 'hsearch'
            [Xm, ym, n, Approx] = graddesc_h(F, X0, y0, e, n, Approx, params.h);
            return
        case 'coord'
            [Xm, ym, n, Approx] = graddesc_coord(F, X0, y0, e, n, Approx, params.a, params.b);
            return
    end
end

function [Xm, ym, n, Approx] = graddesc_h(F, X0, y0, e, n, Approx, h)
    Approx = [Approx; [X0, y0]];

    [GX0, n1] = grad(F, X0, y0, 0.0001); n += n1;

    % проверяем критерий останова
    if sqrt(sum(GX0.^2)) <= e
        Xm = X0; 
        ym = F(Xm); ++n;
        return
    end 

    % поиск оптимального шага
    if isnan(h)
        fh = @(h) F(X0 - GX0*h);

        [hm, ym, n1] = gold(fh, 0.1, 10, 0.001); n += n1;

        X0 = X0 - GX0*hm;
        y0 = ym;
    else
        while true
            % перемещение точки вдоль антиградиента
            X1 = X0 - GX0*h;

            y1 = F(X1); ++n;
            if (y1 < y0) 
                X0 = X1; 
                y0 = y1; 
                break;
            end 
                
            h = h/2;
        end
    end

    [Xm, ym, n, Approx] = graddesc_h(F, X0, y0, e, n, Approx, h);
end

function [Xm, ym, n, Approx] = graddesc_coord(F, X0, y0, e, n, Approx, a, b)
    Approx = [Approx; [X0, y0]];

    X1 = [];
    for i = 1:length(X0)
        fx = @(x) F([X1, x, X0(i+1:end)]);
        [xm, ym, n1] = gold(fx, a, b, e); n += n1;
        X1 = [X1 xm];

        Approx = [Approx; [[X1, X0(i+1:end)], y0]];
    end

    if all(abs(X1 - X0) <= e)
        Xm = X1;
        ym = F(X1); ++n;
        return
    end

    ++n;
    [Xm, ym, n, Approx] = graddesc_coord(F, X1, F(X1), e, n, Approx, a, b);
end
