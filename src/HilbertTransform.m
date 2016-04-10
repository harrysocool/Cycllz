
one = randi(normal,1,1);

t = wav{one,RAW}{2,1};
w = wav{one,RAW}{2,2};
e = 0;
for i = 1:length(w)
    temp = 0;
    for j = 1:length(w)
        temp1 = w(j)/(j-i);
        if(isinf(temp1))
            temp1 = 0;
        end
        temp = temp + temp1;
    end
    e(i,1) = temp/pi;
end

subplot(211)
plot(t,w)
subplot(212)
plot(t,e)