% one = randi(all,1,1);
% one = 163;

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
if(~isempty(locs1))
    [MAX,idx1] = max(pks1);

    j = idx1-1;

    for i = j:-1:1
        temp = MAX*3/4;
        if(pks1(i) > temp)
            idx1 = i;
        end
    end

    d = 0.9*locs1(idx1);
    p = pks1(idx1)/4.5;
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
plot(d,0,'rx');
plot(locs1,pks1,'rx');
plot(locs2,pks2,'ob');

disp([num2str(one),' ',wav{one,2},' ',num2str(s),' ',num2str(me)]);
