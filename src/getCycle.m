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
    [pks1, locs1] = findpeaks(a(N_st:length(a)),t(N_st:length(a)),'MinPeakDistance',t(50),'MinPeakHeight',median(a),'MinPeakProminence',median(a));
    if(length(locs1)>2)
%         [MAX,idx1] = max(pks1);
        [~,idx] = sort(pks1,'descend');

        j = idx(2);

        for i = j-1:-1:1
            temp = pks1(j)*2/3;
            if(pks1(i) > temp)
                j = i;
            end
        end

        d = 0.9*locs1(j);
        p = pks1(j)/4.5;
    else
        d = t(round(length(t)/2));
        p = median(a);
    end
    [~, locs2] = findpeaks(a(N_st:length(a)),t(N_st:length(a)),'MinPeakDistance',d,'MinPeakHeight',p,'MinPeakProminence',median(a));
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