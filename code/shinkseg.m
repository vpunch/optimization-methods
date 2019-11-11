% анимация изменения отрезка

function shinkseg(st, en, line, timeout)
    X = get(line, 'XData');
    
    for d = st : len(st, en) / 30 : en
        if (st > en)
            X(2) = d;
            set(line, 'XData', X);
        else
            X(1) = d;
            set(line, 'XData', X);
        end 
        
        pause(0.01);
    end 
    
    pause(timeout);
end
