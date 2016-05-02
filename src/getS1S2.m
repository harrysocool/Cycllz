function s = getS1S2(t,w,inter,i50,t_st)
    %% Derivate to get local max & min, then peaks
    dw = [w(1);diff(w)];
    local_mm = cell(0);
    pks_loca = cell(0);
    pks_idx = zeros(length(w),1);
    for i = 1:length(w)-1
        if(dw(i)<0 && dw(i+1)>0)
            local_mm(size(local_mm,1)+1,:) = {t(i),w(i),-1,i};
        elseif(dw(i)>0 && dw(i+1)<0)
            local_mm(size(local_mm,1)+1,:) = {t(i),w(i),1,i};
        end
    end
    for i = 1:size(local_mm,1)-2
        if(local_mm{i,3}<0 && local_mm{i+1,3}>0 && local_mm{i+2,3}<0)
            pks_loca(size(pks_loca,1)+1,:) = [local_mm(i+1,:),i];
            pks_idx(local_mm{i+1,4},1) = size(pks_loca,1);
        end
    end
    %% filtered peaks by Heron's formula area
    area = getArea(pks_loca,local_mm);
    mu = mean(area);

    new_locs = cell(0);
    for i = 1:size(area,1)
        if(area(i)>=mu)
           new_locs(size(new_locs,1)+1,:) = pks_loca(i,:); 
        end
    end
    
    interval = inter - 1;
    interval50 = i50 + 3;
    interN = diff(cell2mat(new_locs(:,4)));
    I = find(interN<=interval50);
    temp_pks1 = new_locs(I,:);
    for i = 1:length(I)
        temp_pks = {};
        II = find(cell2mat(new_locs(:,4))==temp_pks1{i,4});
        if(~isempty(II) & (II ~= size(new_locs,1)))
            temp_pks(size(temp_pks,1)+1:size(temp_pks,1)+2,:) = new_locs(II:II+1,:);
            [~,III] = sort(cell2mat(temp_pks(:,2)),'descend');
            IIII = find(cell2mat(new_locs(:,4))==temp_pks{III(2),4});
            new_locs(IIII(1),:) = [];
        end
    end
    
    [~,idx3] = sort(cell2mat(new_locs(:,1)),'ascend');
    new_locs = new_locs(idx3,:);
    [~,idx4,~] = unique(cell2mat(new_locs(:,1)));
    new_locs = new_locs(idx4,:);
    %% Enhanced Salman method by shifting windows
    new_locs1 = cell(0);
    plot_interval = cell(0);

%     T_st = new_locs{1,4}-2;
    T_st = find(t == t_st) - 2;
    for i = T_st:interval:length(t)
        T_end = i+interval;
        if(T_end<=length(t))
            idx = pks_idx(i:T_end);
        else
            idx = pks_idx(i:length(t));
        end
        idx = idx(logical(idx));
        temp_pks_loca = pks_loca(idx,:);
        temp_area = getArea(temp_pks_loca,local_mm);

        mu = mean(temp_area) - std(temp_area);

        for j = 1:size(temp_area,1) 
            if(temp_area(j)>=mu)
               new_locs1(size(new_locs1,1)+1,:) = temp_pks_loca(j,:); 
            end
        end
        plot_interval(size(plot_interval,1)+1,:) = {t(i),0};
    end
%% 2nd Enhanced Salman method by pick the right peaks
% combine the splitted S1/S2
    if(~isempty(new_locs1))
        interN = diff(cell2mat(new_locs1(:,4)));
        I = find(interN<=interval50);
        temp_pks1 = new_locs1(I,:);
        for i = 1:length(I)
            temp_pks = {};
            II = find(cell2mat(new_locs1(:,4))==temp_pks1{i,4});
            if(~isempty(II) & (II ~= size(new_locs1,1)))
                temp_pks(size(temp_pks,1)+1:size(temp_pks,1)+2,:) = new_locs1(II:II+1,:);
                [~,III] = sort(cell2mat(temp_pks(:,2)),'descend');
                IIII = find(cell2mat(new_locs1(:,4))==temp_pks{III(2),4});
                new_locs1(IIII(1),:) = [];
            end
        end

        % only pick biggest three or two peaks in one cycle window
        new_locs2 = cell(0);
        for i = T_st:interval:length(t)
            T_end = i+interval;
            temp_idx = cell2mat(new_locs1(:,4));
            idx1 = find((temp_idx >= i) & (temp_idx <= T_end));
            temp_pks2 = cell2mat(new_locs1(idx1,2));
            [~,idx2] = sort(temp_pks2,'descend');
            if(length(idx2)==2)
                new_locs2(size(new_locs2,1)+1:size(new_locs2,1)+2,:) = new_locs1(idx1(idx2(1:2)),:);
            elseif(length(idx2)>2)
                if(temp_pks2(idx2(3)) >= 0.5*temp_pks2(idx2(2)))
                    new_locs2(size(new_locs2,1)+1:size(new_locs2,1)+3,:) = new_locs1(idx1(idx2(1:3)),:);
                else
                    new_locs2(size(new_locs2,1)+1:size(new_locs2,1)+2,:) = new_locs1(idx1(idx2(1:2)),:);
                end
            elseif(~isempty(idx2))
                new_locs2(size(new_locs2,1)+1,:) = new_locs1(idx1(idx2(1)),:);
            end
        end

        [~,idx3] = sort(cell2mat(new_locs2(:,1)),'ascend');
        new_locs2 = new_locs2(idx3,:);
        [~,idx4,~] = unique(cell2mat(new_locs2(:,1)));
        new_locs2 = new_locs2(idx4,:);
    else
        new_locs2 = new_locs;
    end
    
    %% Decide which new_locs to choose
    s = cell(0);
    s(1,:) = {'Time','Peaks location','if Wrong, 1'};
    wrong_peaks = find(cell2mat(new_locs2(:,2)) < 0.05);
    if(length(wrong_peaks) > 5)
        s(2,:) = {new_locs(:,1),new_locs(:,2),1};
    else
        s(2,:) = {new_locs2(:,1),new_locs2(:,2),0};
    end
end
