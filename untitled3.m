s = zeros(0);
t = zeros(0);
for i = 1:size(wav,1)-1
    t(i,1) = wav{i+1,CYCLE}{2,3};
    s(i,1) = wav{i+1,CYCLE}{2,5};
end
%%
plot(t(artifact(1):artifact(2)),s(artifact(1):artifact(2)),'ro');hold on
%%
plot(t(extrahls(1):extrahls(2)),s(extrahls(1):extrahls(2)),'bx');
%%
plot(t(murmur(1):murmur(2)),s(murmur(1):murmur(2)),'go');
%%
plot(t(normal(1):normal(2)),s(normal(1):normal(2)),'mx');
%%
legend('artifact','extrahls','murmur','normal');