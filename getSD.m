function c = getSD(t)
    d = diff(cell2mat(t));
    [h,~] = hist(d,linspace(0,1,10));
    c = h;
end
