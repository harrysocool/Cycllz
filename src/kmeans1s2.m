
plot(wav{95,6}{2,1},wav{95,6}{2,2})
[pks,locs]=findpeaks(wav{95,6}{2,2},wav{95,6}{2,1});
text(locs+.02,pks,num2str((1:numel(pks))'))
X=[pks];
[idx,C] = kmeans(X,3);
Y=[pks,locs];
a=length(pks);
A=zero(a,2);

for i=1:a
    if Y(i,1)>=max(C)
       A=Y(i,:)
