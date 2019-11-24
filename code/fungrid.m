function [XX1, XX2, YY] = fungrid(F, from, to, density)
    X1 = X2 = linspace(from, to, density);
    [XX2, XX1] = meshgrid(X2, X1);

    YY = [];
    for i = 1:length(X1)
        Y = [];
        for j = 1:length(X2)
            Y = [Y, F([X1(i) X2(j)])];
        end
        YY = [YY; Y];
    end
end
