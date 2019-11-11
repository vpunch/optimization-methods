% метод парабол

function [xm, ym, n, Approx] = parab(f, a, b, e)
    Approx = [];

    % точки пересечений
    [x1 x3 n] = minloc(f, a, (b-a)/4); %или a b
    x2 = x1 + (x3 - x1) * rand(); %(a + b) / 2
    
    [y1 y2 y3] = deal(f(x1), f(x2), f(x3));
    n += 3; 
    
    x42 = NaN;
    x41 = NaN;
    while true
        a0 = y1;
        a1 = (y2 - y1) / (x2 - x1);
        a2 = 1 / (x3 - x2) * ((y3 - y1) / (x3 - x1) - (y2 - y1) / (x2 - x1));
        
        Approx = [Approx; [a0, a1, a2, x1, x2]];
        
        x42 = x41;
        % минимум параболы
        x41 = 1/2 * (x1 + x2 - a1/a2);
        
        ++n;
        if (x41 > x2)
            [x1 y1] = deal(x2, y2);
            [x2 y2] = deal(x41, f(x41));
        else
            [x1 y1] = deal(x41, f(x41));
        end 
        
        if (!isnan(x42) && abs(x41 - x42) <= e)
            break;
        end 
    end 
    
    xm = x41;
    ym = f(xm); ++n;
end
