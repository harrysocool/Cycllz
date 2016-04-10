function cc = getCycle(t,w)
    cc(1,:) = {'peak cycle array','cycle time median','cycle time samples Number','50ms samples number','std'};
    a = [];
    N = size(t,1);
    for m = 1:length(w)
        temp = 0; 
        for i = 1:length(w)-m-1
            temp = temp + w(i)*w(i+m);
        end
        a(m,1) = temp;
    end

    if(length(t) <= 200)
        N_st = 10;
    else
        N_st = 30;
    end
    [pks1, locs1] = findpeaks(a(N_st:length(a)),t(N_st:length(a)),'MinPeakDistance',t(50),'MinPeakHeight',median(a));

    [MAX,idx1] = max(pks1);

    j = idx1-1;

    for i = j:-1:1
        temp = MAX*3/4;
        if(pks1(i) > temp)
            idx1 = i;
        end
    end

    d = 0.9*locs1(idx1);
    [~, locs2] = findpeaks(a(N_st:length(a)),t(N_st:length(a)),'MinPeakDistance',d,'MinPeakHeight',pks1(idx1)/4.5);
    c = diff([0;locs2]);

    
    if(length(c)<3)
        c = 0;
        me = mean(c);
        interN = length(t);
        inter50 = round(0.05/(t(length(t))/N));
        s = t(length(t));
    else
        me = mean(c);
        interN = round(me/(t(length(t))/N));
        inter50 = round(0.05/(t(length(t))/N));
        s = std(diff(locs2));
    end
    cc(2,:) = {locs2,me,interN,inter50,s};
end