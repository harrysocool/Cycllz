function c = getSD(t)
    d = diff(cell2mat(t));
    [h,~] = hist(d,linspace(0.2,1,20));
    c = h;
end
