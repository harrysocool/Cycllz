function getNplot(N,wav,raw,d,t)
    temp = 0;
    if strcmp(t,'FFT')
        figure('Name',[wav{1,raw},' vs. ',wav{1,d}])
        for i = 1:2:2*size(N,2)
           temp = temp + 1;
           subplot(size(N,2),2,i);
           plot(wav{N(temp)+1,raw+1}{2,1},wav{N(temp)+1,raw+1}{2,2});
           xlim([0 400])
           title([wav{N(temp)+1,2},' NO.',num2str(N(temp)+1)])
       
           subplot(size(N,2),2,i+1); 
           plot(wav{N(temp)+1,d+1}{2,1},wav{N(temp)+1,d+1}{2,2});
           title([wav{N(temp)+1,2},' NO.',num2str(N(temp)+1)])
           xlim([0 400])
        end
    elseif strcmp(t,'signal')
        figure('Name',[wav{1,raw},' vs. ',wav{1,d}])
        for i = 1:2:2*size(N,2)
           temp = temp + 1;
           subplot(size(N,2),2,i);
           plot(wav{N(temp)+1,raw}{2,1},wav{N(temp)+1,raw}{2,2});
           title([wav{N(temp)+1,2},' NO.',num2str(N(temp)+1)])
           ylim([-0.5 0.5])
           
           subplot(size(N,2),2,i+1); 
           plot(wav{N(temp)+1,d}{2,1},wav{N(temp)+1,d}{2,2});
           ylim([-0.5 0.5])
           title([wav{N(temp)+1,2},' NO.',num2str(N(temp)+1)])
        end
    elseif strcmp(t,'energy')
        figure('Name',[wav{1,raw},' vs. ',wav{1,d}])
         for i = 1:2:2*size(N,2)
           temp = temp + 1;
                      
           subplot(size(N,2),2,i);
           plot(wav{N(temp)+1,raw}{2,1},wav{N(temp)+1,raw}{2,2});       
           title([wav{N(temp)+1,2},' NO.',num2str(N(temp)+1)])
           ylim([0 1])
           
           subplot(size(N,2),2,i+1); 
           plot(wav{N(temp)+1,d}{2,1},wav{N(temp)+1,d}{2,2});
           title([wav{N(temp)+1,2},' NO.',num2str(N(temp)+1)])
           ylim([0 1])
         end 
    elseif strcmp(t,'s1s2')
        figure('Name',[wav{1,raw},' vs. ',wav{1,d}])
         for i = 1:size(N,2)
                      
           subplot(size(N,2),1,i);
            plot(wav{N(i)+1,raw}{2,1},wav{N(i)+1,raw}{2,2});
            title([wav{N(i)+1,2},' NO.',num2str(N(i)+1)])
            hold on
            plot(cell2mat(wav{N(i)+1,d}{2,1}),cell2mat(wav{N(i)+1,d}{2,2}),'ro');
           hold off;
        end 
    end
end