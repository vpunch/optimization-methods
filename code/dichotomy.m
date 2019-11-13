% Copyright © 2019 Panchishin Ivan

% метод дихотомии
% dichotomy method

function [xm, ym, info] = dichotomy(f, a, b, e)
    info.nstep = 0;
    info.ncalc = 1;
    info.Approx = [a, b];

    d = e; %rand() * 2 * e;

    while ((b - a) / 2 > e)
        [x1 x2] = deal((a + b - d) / 2, (a + b + d) / 2);

        if (f(x2) > f(x1))
            b = x2;
        else
            a = x1;
        end

        ++info.nstep;
        info.ncalc += 2;
        info.Approx = [info.Approx; [a, b]];
    end

    xm = (a + b) / 2;
    ym = f(xm);
end
