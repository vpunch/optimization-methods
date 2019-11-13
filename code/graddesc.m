% Copyright © 2019 Panchishin Ivan

% градиентный спуск
% gradient descent

% type - тип спуска
% params - дополнительные параметры, которые зависят от типа спуска
% Approx - позволяет восстановить путь перемещения точки

function [Xm, ym, info] = graddesc(F, X0, e, type, params)
    y0 = F(X0);

    switch type
        case 'primal'
            [Xm, ym, info] = graddesc_h(F, X0, y0, e, NaN);
        case 'hsearch'
            [Xm, ym, info] = graddesc_h(F, X0, y0, e, params.h);
        case 'coord'
            [Xm, ym, info] = graddesc_coord(F, X0, y0, e, params.a, params.b);
    end

    ++info.ncalc;
end

function [X0, y0, info] = graddesc_h(F, X0, y0, e, h)
    [Gx0, ncalc_Gx0] = grad(F, X0);

    info.ncalc = ncalc_Gx0;
    info.Approx = [X0, y0];

    % проверяем критерий останова (длина вектора)
    if (sqrt(sum(Gx0.^2)) <= e)
        return
    end 

    info.nstep = 1;

    % поиск оптимального шага
    if isnan(h)
        fh = @(h) F(X0 - Gx0 * h);
        [hm, ym, info_hm] = gold(fh, 0.1, 10, e);
        info.ncalc += info_hm.ncalc;

        X0 = X0 - Gx0 * hm;
        y0 = ym;
    else
        while true
            % перемещение точки вдоль антиградиента
            X1 = X0 - Gx0 * h;

            y1 = F(X1);
            ++info.ncalc;
            if (y1 < y0)
                X0 = X1;
                y0 = y1;
                break;
            end 
                
            h = h / 2;
        end
    end

    [X0, y0, info1] = graddesc_h(F, X0, y0, e, h);

    info.nstep += info1.nstep;
    info.ncalc += info1.ncalc;
    info.Approx = [info.Approx; info1.Approx];
end

function [X1, ym, info] = graddesc_coord(F, X0, y0, e, a, b)
    info.nstep = 1;
    info.ncalc = 0;
    info.Approx = [X0, y0]

    X1 = [];
    ym = NaN;
    for i = 1:length(X0)
        fx = @(x) F([X1, x, X0(i+1:end)]);
        [xm, ym, info_xm] = gold(fx, a, b, e);

        X1 = [X1, xm];

        info.ncalc += info_xm.ncalc;
        info.Approx = [info.Approx; [[X1, X0(i+1:end)], ym]];
    end

    if all(abs(X1 - X0) <= e)
        return
    end

    [X1, ym, info1] = graddesc_coord(F, X1, ym, e, a, b);

    info.nstep += info1.nstep;
    info.ncalc += info1.ncalc;
    info.Approx = [info.Approx; info1.Approx];
end
