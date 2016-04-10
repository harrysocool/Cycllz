% one = randi(all,1,1);
% one = 67;

t = wav{one,ENERGY}{2,1};
w = wav{one,ENERGY}{2,2};

a = zeros(0);
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
if(length(locs1)>=2)
    [MAX,idx1] = max(pks1);
    [pks,idx] = sort(pks1,'descend');

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
[pks2, locs2] = findpeaks(a(N_st:length(a)),t(N_st:length(a)),'MinPeakDistance',d,'MinPeakHeight',p,'MinPeakProminence',median(a));
c = diff([0;locs2]);

    if(length(c)<3)
        c = 0;
        me = median(c);
        interN = length(t);
        inter50 = round(0.05/(t(length(t))/N));
        s = t(length(t));
    else
        me = median(c);
        interN = round(me/(t(length(t))/N));
        inter50 = round(0.05/(t(length(t))/N));
        s = std(diff(locs2));
    end
%%
figure('Position',[600 100 550 150])
plot(t,a);hold on
plot(d,0,'go');
plot(locs1,pks1,'rx');
plot(locs2,pks2,'ob');

disp([num2str(one),' ',wav{one,2},' ',num2str(s),' ',num2str(me)]);
