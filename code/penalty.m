% Copyright © 2019 Panchishin Ivan

% метод штрафных функций
% penalty method

% G - массив штрафных функций (отрицательное значение в ограничивающей области)
% r - строгость штрафа
% type - метод внешней (interior) или внутренней (exterior) точки

function p = penalty(F, G, X, r, type)
    Gres = [];
    for i = 1:length(G)
        Gres = [Gres, G{i}(X)];
    end

    if (nargin == 5 && type == 'interior')
        p = F(X) - 1/r * sum(1./Gres);
        return
    end

    % exterior
    p = F(X) + r*sum(cut(Gres) .^2);
end

% функция срезки
function res = cut(x)
    res = (x > 0) .* x;
end
