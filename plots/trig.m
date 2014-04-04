function Y = trig(x)
    a = 2;
    m = 4;
    b = 6;
    
    if x <= a
        Y = 0;
    elseif a < x && x <= m
        Y = (x - a)/(m-a);
    elseif m < x && x < b
        Y = (b-x)/(b-m);
    elseif x >= b
        Y = 0;
    end
end